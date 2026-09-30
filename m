Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD373D1A97
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 18:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790794212; cv=none; b=Eub0omi8OFOClGT0MmN4Dl2li+zqTlgBmCt1p5nyajhAQgOWuyItBBqKwu+AwDmQkMagGfIpFNdY+OgMhlzGwhQ+wGxkaFjc+iAypOOU/rkS+oDFu6y69d5tULypVGiYmNJbVM6mM/KY/OzKG3r46BTEWvlKHNGtoNDeKa47RD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790794212; c=relaxed/simple;
	bh=vV9UjkLOrEdFe8QT+q9z6IENIPWK9hQtUIVx9jzhXKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WX6406WBbr1RtfUOSTrWdBw+JpsaNy0VUh++S87hcJySjjw15PcBAgbZ/X9vcRQ000avjiZDSOzWDPvu/yp5PhTzOU3XKm3Bwa8FEoHVBzGN/nR2b38G2KgqOi2Jh0eE/r9ogK2F0+b0D6PPvgOSDcUbj5pFMuv2oqg1cJU9HZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jorFUYqO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jorFUYqO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C6F21F000FF;
	Wed, 30 Sep 2026 18:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790794211;
	bh=NA7RqzyVZ3rN2IVqd9zkwJxn7a2XRbWr7Dr7h1wf9qU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jorFUYqODpwNMeu388SHSmMaVk17vPEHj2ZXVE6XKL+ehR/BOQLS/xh3Oa7KxThqH
	 TWcbWuof3d0nyyHVqdRfA9WZpxik5da1LRNsiZil/gVtln50DOKlbOa7Q0mPNMXZTk
	 IeeO6KkcNVOvF64qzR4bgtPQ0IpntfOckPzfNPYq3igUbTrPRHb4Rvu+EGJYcMFZ3z
	 u1uxeTyV46duSJTeJTMYim3F5YLdSMdLRk0Dsxf3h2XnNqjmO+3j7SKWwEqbqgUEKU
	 hZspT5J1OWctVSTNbrrZ4KPciVYYvlM9qrW7iu3WVzrEiViLJJb7iT8ZZsjQZwTJ9G
	 juyJ/iaJlrnsw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Adarsh Das <adarshdas950@gmail.com>,
	syzbot+eeb58d2197d88720a228@syzkaller.appspotmail.com,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/3] smb: client: delete compound mids on send failure before unlock
Date: Wed, 30 Sep 2026 14:50:06 -0400
Message-ID: <20260930185006.338236-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930185006.338236-1-sashal@kernel.org>
References: <2026092926-stopwatch-rumbling-2993@gregkh>
 <20260930185006.338236-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Adarsh Das <adarshdas950@gmail.com>

[ Upstream commit 8f6f8a48399f82f4a83f7b9f25b9707e0062a4f9 ]

When sending a compound request fails, smb_send_rqst() kicks off a
reconnect. compound_send_recv() still has those mids on pending_mid_q,
but it unlocks the server without removing them first.

During reconnect, cifs_abort_connection() walks pending_mid_q and runs
each mid callback. With no response yet, those callbacks return credits
and drop in_flight. Then compound_send_recv()'s send-error path returns
the same credits again. in_flight ends up decremented twice and
smb2_add_credits() WARNs.

syzbot hits this during SMB2_negotiate when the socket send fails.

cifs_call_async() already calls delete_mid() before unlock on send
failure. Do the same for compound chains and set cancelled_mid[] so the
out: path does not delete them again.

Fixes: ee258d79159a ("CIFS: Move credit processing to mid callbacks for SMB3")
Reported-by: syzbot+eeb58d2197d88720a228@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/r/6a727d22.40259c87.584f4.04ce.GAE@google.com
Tested-by: syzbot+eeb58d2197d88720a228@syzkaller.appspotmail.com
Assisted-by: LLM
Cc: stable@vger.kernel.org
Signed-off-by: Adarsh Das <adarshdas950@gmail.com>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/transport.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/smb/client/transport.c b/fs/smb/client/transport.c
index f3eb7c6b641d1..ec22ce90c0f60 100644
--- a/fs/smb/client/transport.c
+++ b/fs/smb/client/transport.c
@@ -1183,6 +1183,10 @@ compound_send_recv(const unsigned int xid, struct cifs_ses *ses,
 	if (rc < 0) {
 		revert_current_mid(server, num_rqst);
 		server->sequence_number -= 2;
+		for (i = 0; i < num_rqst; i++) {
+			delete_mid(server, mid[i]);
+			cancelled_mid[i] = true;
+		}
 	}
 
 	cifs_server_unlock(server);
-- 
2.53.0

