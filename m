Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3798A2FDC20;
	Wed,  3 Jun 2026 13:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780493525; cv=none; b=G4yaFnp76kQ9gvwqiotsOoLmez6r/p1SOEyy8BvmQ4CRB1T3lznta+7nO2QvrPMKABZBvYDwQHuL2lMxnZGJkWc3kjd8snfHsDRPkkVepSOwO5dEUcuF7N4MzkE7prtWrYTdlNHt5021QRi64lBCNwpc/2yS9JKLjURui0AGYWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780493525; c=relaxed/simple;
	bh=rTzo24Zk76UuxHr/HjUAi0kTmBWzup4CqF0bxxDiUnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Eb3Tf8vkqafkTHHbzrGYFdcmT1w81L9vPgjNPdZEqHI2UY3bc+kgxklQAA8oGE6755BUUQdbMdInLGLtKb6HEMMAhfu8khL6gKKIGz81mmQB9Zuevvjfkk9Fd7pclyrydy5vOcvvxuJs5/0whfFPlcpkOk19gKGBXTRkr61jr+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=flRmu0qK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="flRmu0qK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF2571F00893;
	Wed,  3 Jun 2026 13:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780493523;
	bh=GerNSErSM9cNWQY0CMZxNnigte/XS4geDQjmWKTlK6s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=flRmu0qKW7pTpi1mPXkrtgOMA+wttOp63PRH9vv2hZiJlAuAfAVt9ND6t0M3glNo2
	 wakD3wOS+Dm6yk7U3pY5RTK4Ov/QgqwKui62HKZ0Z3WYjOAJtCpyd7NZZV8b2UqaTS
	 EpltJuGGkfG/6nSdIuxbz3Qr9qA3lZ2xX4sDPqgKrs3Lm6/0lcZlPixt/uDbRjwwDm
	 oBF9VE/s/F+yY2rorwehIgJLUEXvRPTcqFq9R5PDAxp2xOHit84k8b5LKXsD7/BwpI
	 QO2W6k9GthUobXKzsKwN+xMJ+QlocOKH/r17CfGHZpVqTQ2tFP1yQI3WekWxzLKI/w
	 uFBC55KY01sZw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	=?UTF-8?q?Filipe=20La=C3=ADns?= <lains@riseup.net>,
	Bastien Nocera <hadess@hadess.net>,
	Ping Cheng <ping.cheng@wacom.com>,
	Jason Gerecke <jason.gerecke@wacom.com>,
	Viresh Kumar <vireshk@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	greybus-dev@lists.linaro.org,
	linux-staging@lists.linux.dev,
	bpf@vger.kernel.org
Cc: stable@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [linux-6.6.y 3/3] HID: core: Fix size_t specifier in hid_report_raw_event()
Date: Wed,  3 Jun 2026 14:31:27 +0100
Message-ID: <20260603133140.3069226-3-lee@kernel.org>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
In-Reply-To: <20260603133140.3069226-1-lee@kernel.org>
References: <20260603133140.3069226-1-lee@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nathan Chancellor <nathan@kernel.org>

[ Upstream commit 4d3a2a466b8d68d852a1f3bbf11204b718428dc4 ]

When building for 32-bit platforms, for which 'size_t' is
'unsigned int', there are warnings around using the incorrect format
specifier to print bsize in hid_report_raw_event():

  drivers/hid/hid-core.c:2054:29: error: format specifies type 'long' but the argument has type 'size_t' (aka 'unsigned int') [-Werror,-Wformat]
   2053 |                 hid_warn_ratelimited(hid, "Event data for report %d is incorrect (%d vs %ld)\n",
        |                                                                                         ~~~
        |                                                                                         %zu
   2054 |                                      report->id, csize, bsize);
        |                                                         ^~~~~
  drivers/hid/hid-core.c:2076:29: error: format specifies type 'long' but the argument has type 'size_t' (aka 'unsigned int') [-Werror,-Wformat]
   2075 |                 hid_warn_ratelimited(hid, "Event data for report %d was too short (%d vs %ld)\n",
        |                                                                                          ~~~
        |                                                                                          %zu
   2076 |                                      report->id, rsize, bsize);
        |                                                         ^~~~~

Use the proper 'size_t' format specifier, '%zu', to clear up the
warnings.

Cc: stable@vger.kernel.org
Fixes: 2c85c61d1332 ("HID: pass the buffer size to hid_report_raw_event")
Reported-by: Miguel Ojeda <ojeda@kernel.org>
Closes: https://lore.kernel.org/20260516020430.110135-1-ojeda@kernel.org/
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
(cherry picked from commit 3ab135238832446399614e7a4bb796d620717806)
Signed-off-by: Lee Jones <lee@kernel.org>
(cherry picked from commit 76606eed6cb62ec97afcc270948ef8335d02e944)
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/hid/hid-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index c6d98634b97e..2de4d831c526 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2003,7 +2003,7 @@ int hid_report_raw_event(struct hid_device *hid, enum hid_report_type type, u8 *
 		return 0;
 
 	if (unlikely(bsize < csize)) {
-		hid_warn_ratelimited(hid, "Event data for report %d is incorrect (%d vs %ld)\n",
+		hid_warn_ratelimited(hid, "Event data for report %d is incorrect (%d vs %zu)\n",
 				     report->id, csize, bsize);
 		return -EINVAL;
 	}
@@ -2025,7 +2025,7 @@ int hid_report_raw_event(struct hid_device *hid, enum hid_report_type type, u8 *
 		rsize = max_buffer_size;
 
 	if (bsize < rsize) {
-		hid_warn_ratelimited(hid, "Event data for report %d was too short (%d vs %ld)\n",
+		hid_warn_ratelimited(hid, "Event data for report %d was too short (%d vs %zu)\n",
 				     report->id, rsize, bsize);
 		return -EINVAL;
 	}
-- 
2.54.0.1032.g2f8565e1d1-goog

