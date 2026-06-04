Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9D23FD159;
	Thu,  4 Jun 2026 09:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780565237; cv=none; b=AR2w3+s1WmvVJErTTgeRWV9uwYMcAGLglbjVxrQ7TJeC4D2d8EIY774N7zxifoAu9Y4Bkq0Bj6cYy8M9k3eRGdxvrLQ8ursZzm1KMnvPW56XKzRKF2KJ1rvKsznbLmAFr7TgM2rRj2Ow2X/oFBGh6c6HE2tNCrrOr0ZpMFC7dOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780565237; c=relaxed/simple;
	bh=SjM/U004WGDu9lfGjIked+BXK+dA1fpvoD+6Cieo/iI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ngpZ2UnX1/zFoyjvfr71WpycxAMQVNhzqF+eKlmAOneVSEJd1NmTfimCQAHySNU85y2AvulEauHY7LEXG86tWtQ76/ALer46qrynptOInfTDwjPa00hq9XnQGR8i4Q+//l3omqFO6vl7uJOsGyq8KRG5koGxUtJ3x9NekYD+v9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m6fdk5Q2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m6fdk5Q2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 012211F00893;
	Thu,  4 Jun 2026 09:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780565236;
	bh=Y/ISGDFhn+Nt3MpYi8Wixou+ghY4kt+aKNp5hNGAjcs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=m6fdk5Q2fE7svINVgrt1IItTH3rpvPN93kkLp6tn+82SRM59esIdUqdfq/Zye6Kdk
	 CjzcM7GJAeEwf+m4sEkFY0HvklFW/CQEUrQk0ETa7Vodw8aypm6upLa6d/d1KdRLbT
	 ixC2HpYhySo3jcak8Fm47Vr8tX4q9BAyx9tvTHgqfb4bgOpDyF+8ogYPkWooSepT2P
	 36QEfwfY3KZeQjyOFBWmt13+sPyURzkR77po5tHIrODb/dEAzRH23GjeIgdNfRBhLx
	 aE9/yIMPrO7ESo38mGlXKH2cvziIQJ17tu6ENsntvb6CfKTIAiZUg5U8HJCX7VO1GP
	 O8qBsgDZ60wlw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	Viresh Kumar <vireshk@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	greybus-dev@lists.linaro.org,
	linux-staging@lists.linux.dev
Cc: stable@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [linux-5.15.y 3/3] HID: core: Fix size_t specifier in hid_report_raw_event()
Date: Thu,  4 Jun 2026 10:26:52 +0100
Message-ID: <20260604092659.3953067-3-lee@kernel.org>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
In-Reply-To: <20260604092659.3953067-1-lee@kernel.org>
References: <20260604092659.3953067-1-lee@kernel.org>
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
(cherry picked from commit 0f77a993b5426cca1b046c9ab4b2f8355a4d45dc)
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/hid/hid-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index a8d4673c7b8e..e106b59b55da 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1793,7 +1793,7 @@ int hid_report_raw_event(struct hid_device *hid, int type, u8 *data,
 		return 0;
 
 	if (unlikely(bsize < csize)) {
-		hid_warn_ratelimited(hid, "Event data for report %d is incorrect (%d vs %ld)\n",
+		hid_warn_ratelimited(hid, "Event data for report %d is incorrect (%d vs %zu)\n",
 				     report->id, csize, bsize);
 		return -EINVAL;
 	}
@@ -1815,7 +1815,7 @@ int hid_report_raw_event(struct hid_device *hid, int type, u8 *data,
 		rsize = max_buffer_size;
 
 	if (bsize < rsize) {
-		hid_warn_ratelimited(hid, "Event data for report %d was too short (%d vs %ld)\n",
+		hid_warn_ratelimited(hid, "Event data for report %d was too short (%d vs %zu)\n",
 				     report->id, rsize, bsize);
 		return -EINVAL;
 	}
-- 
2.54.0.1032.g2f8565e1d1-goog

