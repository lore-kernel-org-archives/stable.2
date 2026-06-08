Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0B03CF96B;
	Mon,  8 Jun 2026 10:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780912977; cv=none; b=Tjy1SrJjZp9D8r+H1EtV3UWAfG7MEC/LT9WHWfgaDrAuVhCd8/en7em/0NOOjrbMBMwYzjJmhfnPL14r9iyGq47MX8F9UqieoquhTD+F+x+9nH6QYd+izVcM/pGsQYdOPNPY7D7c8SZ08P8+i2Nn/LbwYttHtAguvSwrTOJR+2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780912977; c=relaxed/simple;
	bh=YxtLRgwLaHrh2NKtEkwKJFIIFMvFZNT6m7aIjkRuOIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fVF77OKhS82w5ma02q+vCNwZedf4IumbuBjcT/M5u6g3U/ayX9uscL4w/rwJ+1aLq89bmHgM2K1umoQeUtMMXDVkyOGLFKdPFA8Y1MJufr5VFmxtQw47a2L7AFa6XW5mKqzSBneRkfd9rXooa1JUjV50xAznK7QDJenp87e98UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CRuzUw5E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CRuzUw5E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A95031F00898;
	Mon,  8 Jun 2026 10:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780912976;
	bh=/QXrcAW+83usX+8UQmHsCIedtLj7Ml5HD0UO3OewzHE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CRuzUw5E5kK23gYjHONHF/5fKIKdNq6KyWHV3OpH9LCJWys9GBkVft7AmvNxr+xKv
	 Qmizj8ZGZ8pBU01R31KT1lyNIHv0gRXgVQ0mTVUiTP0FDQCOZn+Y2GIe3VYg8NFIVC
	 jGJ4UdI0eFD9x+JBliqYuHsvO8ROfPueB1zMCYVXxJ7YDAxXSkIEMp4n3rchQL5l3e
	 hujUkPbuYhHoa5huvU4ndfr0AWEtYwpbqsIF/vqh4imYy1y3SURGrz4XMSsknObCDU
	 dMopxT0yntsoAWsxOjMmEksRZvC9VnpYjZfsSn70xshA3pZfzjKqQGOBp5JCsNh/o7
	 Hn0zxH8sc22jw==
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
Subject: [linux-5.10.y 3/3] HID: core: Fix size_t specifier in hid_report_raw_event()
Date: Mon,  8 Jun 2026 11:02:25 +0100
Message-ID: <20260608100236.2781796-3-lee@kernel.org>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
In-Reply-To: <20260608100236.2781796-1-lee@kernel.org>
References: <20260608100236.2781796-1-lee@kernel.org>
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
(cherry picked from commit 70333a8f866aad8cbd6956e2ec4ace159fa4243b)
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/hid/hid-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index c73f4ac16fdf..918c66d5bc93 100644
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

