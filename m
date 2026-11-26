Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795666188;
	b=ZbUWdnxZjQ1+lNkvcH3kv1LKCkN91cYrQRCeV1XO9MFU5bBuGHaZLPttAbWlYlcEc8zm
	 TXKcpkI9dMAe3/UHwhTlEYUH4WvXyDr7w7dO8SL2ayIeCS1SLR77G6cw5r1HsP3Xpa7C4
	 hErwD7wu4eN7EOserYYw7fOJIclKDMctIuYREShvEn6a8CpZn/JSGiGvP0pmmtBZa0QWd
	 i2Wa1R0c2uRWm7Udz/yq3ApaF9Kq2JbVEvTnLAU4otlDmKchZiSdjehK2z1ky6yJxKs8/
	 p+PRuM2rX8WlrnCeAqYCsyU247ekOaHkcMhd20PrG9SXxkT7rM7yYZ9GBYHSjg3Jkag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795666188;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=kYItLN23Eh+kYPufqLTkdCXf0+Q98GPcNEBa5iDnnMg=;
	b=kQu1ePFlUjDpJRXTh/+V3IBuW17uQrrPcJC8kVXbITsTfcg9gOyuDtp68CTUO/sohpCx
	 FXZdnt1b4wXhsRzO7gT5AUdP4lXIpt5CC4uX6XuuNHDhnS15QgrCYA5EsjZ3UNsuOrK6q
	 OsX9w5a/CLZlbO9xolylZdnTs7y54IimhXcGh1q2J+5MjyM2vuppjvudpeQKKBBhMxhsb
	 8VJ2/733X16xSRUet08YuyxrbSPsQiXFQMFBTnDDercuo2ezbIlMPaQjOW6DIH5bVHGyE
	 Z+ujulYm+M5oJqcFozMdwCMEDYPpauWauZXI1EBeQ718Ga5CM72IlZxeEHR72dVDsSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YOSQlpfK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33DB606A327
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 04:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YOSQlpfK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDD041F000C0;
	Thu, 26 Nov 2026 04:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795666187;
	bh=kYItLN23Eh+kYPufqLTkdCXf0+Q98GPcNEBa5iDnnMg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YOSQlpfKkng+TVrN48ctG9E7bQp79L/UKpx7fXzbXFI+Be1oxPMNLJLbD2qqcW7FT
	 eI65LHqfAGII91vlB4ZvRno8NSd8TCXH/NK7dYCfVeC10N0RkFvNTtUaerz/JzywTY
	 mM4DCLHemAbFbi09SkQwy54H/9m4wXiaIjEy4aBHmI0A+p/L1ELfFD8MOU+F7UDfVG
	 mb5hFhOzJvBhGkk/M4/6Hjn7RXFMc5RSghcCwnvnvKxrPsDHQpLNdXQiO2AyQZeTIf
	 wSzupWuf56sMAMwmLQiVOmQgG3u5upOA2ACmD2IAKnh7UyQNecXI1/r8NBvmvH1nWq
	 qRVaTAIdJaihA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Joseph Qi <joseph.qi@linux.alibaba.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] smb: client: skip NULL channel in __cifs_put_smb_ses()
Date: Wed, 25 Nov 2026 23:09:45 -0500
Message-ID: <20261126040921.1913836-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112549-explain-affecting-e4d8@gregkh>
References: <2026112549-explain-affecting-e4d8@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joseph Qi <joseph.qi@linux.alibaba.com>

[ Upstream commit 8deaf64a59a263161dfc5128f8398fb3dcba4fac ]

cifs_chan_skip_or_disable() clears a secondary channel's slot in the
session (ses->chans[chan_index].server = NULL) without lowering
chan_count when the server stops supporting multichannel.  When the
session is later released, __cifs_put_smb_ses() walks every slot up to
chan_count and calls cifs_put_tcp_session() on it, which dereferences
the server pointer immediately, so a slot left NULL by the skip path
makes the release crash with a NULL pointer dereference.

Clearing a slot without lowering chan_count is older than
cifs_chan_skip_or_disable(): cifs_chan_update_iface() could already do
the same since commit b54034a73baf9 ("cifs: during reconnect, update
interface if necessary"), and the release loop has been unguarded
since then.  Commit 12d1e301bdfd1 ("cifs: do not let
cifs_chan_update_iface deallocate channels") later removed that
trigger, but the crash is reachable through it on older kernels.

cifs_decrease_secondary_channels() already guards the same put with
if (server).  Add the same guard to the release loop so a skipped
channel slot is left alone.

Fixes: b54034a73baf9 ("cifs: during reconnect, update interface if necessary")
Cc: stable@vger.kernel.org
Signed-off-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>
[ sashal: adapted the hunk to this tree's cifs_put_smb_ses() loop, which is nested one level deeper and uses a cached chan_count, so the NULL-check guard sits at different indentation and context. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/connect.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index df8634228cbad..8d2a586f9631c 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -2103,7 +2103,8 @@ void cifs_put_smb_ses(struct cifs_ses *ses)
 				kref_put(&ses->chans[i].iface->refcount, release_iface);
 				ses->chans[i].iface = NULL;
 			}
-			cifs_put_tcp_session(ses->chans[i].server, 0);
+			if (ses->chans[i].server)
+				cifs_put_tcp_session(ses->chans[i].server, 0);
 			ses->chans[i].server = NULL;
 		}
 	}
-- 
2.53.0

