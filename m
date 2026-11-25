Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795608772;
	b=3EqNtZr5yHaYDRX43YtGyclbIvjhfSvcRrhiw+cA/EQxLbfO0ZcKjzhGcb2+u1oo4kTl
	 ord5K0WaOG9l4sBgPRyjru1uRhaKijiqiHdaQG/8EdSho2ztgsKc/B/PP2OaoO82YQdWK
	 A8teWOwUWQJATVYii/9P63EV3Uup/6s5jJzqYEJhTWZBVSIFVNa351NoYCxK8cDmmy0rp
	 3IPLnqTBdcAQkjOn/6+SWyzmQNkFcUvF+f5Su9nk9/YSoL0YcUHITk8tfxds60oOkm2uZ
	 0RMFQk+b99VJ0CoOyUrCeCW28n2AD8TvGF118Rvl8Q7eVTtruW/xiLwLinIcEE6YoqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795608772;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=rYPqNNQTB0KS1iZP1Yah3x05x6is9oHmiMLVkcdjRCw=;
	b=oMK3w1OHLTCEP+VylHw4X0tG4oYo2GBGZdYqlP5BuohgGTwYCjSDsg/KJvEpZFrmk9la
	 WXWio51ioXiOeCFdzwxBFyW9sNlDyW+ZxiMP8itJfz/EgGko3O9xvHEUdRHSFfCYQ+nLS
	 JECYfQtB8tywIywAP8zAIDOZL18ivUHSP6nTZTSNYRCg7Z9LPu5OJugjSVEfleX5rj8GE
	 Xu8CBn7s4IABQ6zxLiCs1YdeP1VtynTb3hfZBmcumoG993hg226NDReAo8ER7DL1UqyVC
	 d2R+Ffm/Ndm689nonr+K5lgKtgEYdYAJC0Innt42K1rivWc2t2gYfL4lSG+AE96Q1gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="emTxQ+5/";
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7960B606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 12:12:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7960B606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=emTxQ+5/
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-385d8a00598so8403939eec.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 04:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795608772; x=1796213572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rYPqNNQTB0KS1iZP1Yah3x05x6is9oHmiMLVkcdjRCw=;
        b=emTxQ+5/WwdMet3hczmEvvqlS8s/6vNiHs/wlvNhM6fF6pOBHmriEXXhMCR+KYoLWZ
         9A+q+jaWvAdPjXdH17hfAV+zUL5jjLHE+ggvjs2a7cFhqjm99XzRoT0zncIQiKlRasJI
         Hk7h61oOd9yXI9QDOav/WWh7nXxBTtHoSczRx7BS+otctELjiSmFc5xv0t/DbSLrru7s
         mpsNduMCW929aLUw0YnthTSoHylbs+G1CYT+DpiyV+qIz/WB4yhyEaXnnHZEAAqGAyiX
         BsmY8DQ7G6dZUIwxDWLOymIh7IhgX/9ylxltMHiYR9qfegB9rjCKyHuzM49TevFRKFB2
         raNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795608772; x=1796213572;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rYPqNNQTB0KS1iZP1Yah3x05x6is9oHmiMLVkcdjRCw=;
        b=hx3+d4rcwDj8SaghabQeV5wqv2RvNdWyMSJEuf88fJ54dLk0e9Yqg4WSzmEJjk3E2x
         vmdzTrFevpQGPPTgJzgUjis7u1egaMtFkK4g+1bleDI+NntY4QRhlL97KTfgfG3B6EK+
         vxAxrb4n15TOdTzJIYDI28XcTZ/mroKwbbez0VCRqAKItky3JCy84V9X7iXsNqVYves7
         c0dFMYioh946aBo1gQYt/auRkg/CbYl31wC7ddsw89Hg+cCQGneGoKovu8crFX75k1HC
         0sd4QOZBfl11D4pSZTowUMBtUpudMHGf9GG8+t9IJoygp69VaZMlN31eQTkZSoeXu+qc
         2F/w==
X-Forwarded-Encrypted: i=1; AL+hErECDzUqjZOb9GiXJm0vkE9vvK0rlsnqL44ezts3K2ZAIopqAUgOjRn/FGlk+SkgwdMJJEup8X0=@vger.kernel.org
X-Gm-Message-State: APuU4Z8H7UBYYFodWD1WuYWWP8yVAq43P+6AfigSPViFLNQq95pko4gT
	4edZGG/gbxhKaLQFA9ZIi0D5NfUtoA2Owpr2GLAe1RwA5YbMdp2VPXxx
X-Gm-Gg: AZFdTZfmV8da2NoLoMzzBCU9v9HCrU328jnvO+7aiuAxMuUVTl/bpwKH46L+RSroFPx
	HXfrNOuSheBXw5GrsjE5Wc+1Sy/11u64NonmibDq4Jb+tUACgyJw/Jb7O4c/TrJJCcBTVWdL49o
	zvxuaq6ko/dBTZuJzMwzHyEKxXgAa5wb1vNG/rPrZctTC9DdMKKw3HvpeuAL8bImck6niUf4ZH7
	ctYhn2ko8vFCGjN4HP3HkgEE6VZLACqozYvi6quXcBgWIf3qNHUlJM1QaZKz6axLxySdFiMIpSS
	/SRvApVu5tA46/NXMI7yfugEBAMoPGGEJu6Uk6r0RWPPLOHuadeNMK1oC4T/Zp/FPliQX24ziK0
	ZE5YOzKnb5QUpsb5LprpWwdLOT5lao8P213KvLemV/W5KJrCL1Gfo5Tqq/dY2XmVEOaB2TzmMDR
	iEWP7RNf6iBRFx+KRTTbwe253TybzQWtLIfzVwoBL9ybNySphjWqEPmBPZy/r9gqtmW33sZQBLf
	4Boohoc6tNlJ6JLDuge5HACVjvjxOWkrRvuWmXrC6NDt/cjLCuysfaiAvvdb/49uDOOuWxvDyrO
	ICvB33X6z6qxzRNvupfOeB6ubq8xduqvybUrx1g8gw7kutJbzwhOog==
X-Received: by 2002:a05:7301:4704:b0:383:729:cabe with SMTP id 5a478bee46e88-3856f8519ecmr19175296eec.19.1795608771243;
        Wed, 25 Nov 2026 04:12:51 -0800 (PST)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386c7c62a91sm12234336eec.17.2026.11.25.04.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 04:12:50 -0800 (PST)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Clemens Ladisch <clemens@ladisch.de>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 3/3] ALSA: oxfw: bound the stream format entries to the response length
Date: Wed, 25 Nov 2026 20:12:38 +0800
Message-Id: <20261125121238.1602172-4-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261125121238.1602172-1-maoyixie.tju@gmail.com>
References: <20261125121238.1602172-1-maoyixie.tju@gmail.com>
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

snd_oxfw_stream_parse_format() takes the number of two-byte entries of
a stream format from format[4] and never sees the length of the
response. A count of 254 or 255 can read past the 512-byte response
buffer. An accepted format is stored with the length of its response
and parsed again later. A count that needs more than that length reads
past the copy.

Check the length of a response against its entry count before the
format is parsed or stored. Formats other than AM824 compound still
reach the parser and get -ENXIO.

Found with a CodeQL-based static analysis tool. Reproduced in a
userspace harness under AddressSanitizer. Not tested on hardware.

Fixes: 5cd1d3f47a63 ("ALSA: oxfw: Change the way to make PCM rules/constraints")
Cc: stable@vger.kernel.org
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
I used an LLM to help write the harness and this patch.

 sound/firewire/oxfw/oxfw-stream.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/sound/firewire/oxfw/oxfw-stream.c b/sound/firewire/oxfw/oxfw-stream.c
index 5e36d7153a7b..d8fe136369d8 100644
--- a/sound/firewire/oxfw/oxfw-stream.c
+++ b/sound/firewire/oxfw/oxfw-stream.c
@@ -484,6 +484,19 @@ void snd_oxfw_stream_update_duplex(struct snd_oxfw *oxfw)
 	}
 }
 
+/*
+ * A format of AM824 compound has five bytes, followed by two bytes for each of its entries.
+ * A response can be shorter than that. The parser rejects every other format before it reads
+ * an entry.
+ */
+static bool format_has_all_entries(const u8 *format, unsigned int len)
+{
+	if (len < 2 || format[0] != 0x90 || format[1] != 0x40)
+		return true;
+
+	return len >= 5 && len >= 5 + format[4] * 2;
+}
+
 int snd_oxfw_stream_get_current_formation(struct snd_oxfw *oxfw,
 				enum avc_general_plug_dir dir,
 				struct snd_oxfw_stream_formation *formation)
@@ -501,7 +514,7 @@ int snd_oxfw_stream_get_current_formation(struct snd_oxfw *oxfw,
 
 		err = avc_stream_get_format_single(oxfw->unit, dir, 0, format, &len);
 		if (err >= 0) {
-			if (len < 3)
+			if (len < 3 || !format_has_all_entries(format, len))
 				err = -EIO;
 			else
 				err = snd_oxfw_stream_parse_format(format, formation);
@@ -662,6 +675,11 @@ assume_stream_formats(struct snd_oxfw *oxfw, enum avc_general_plug_dir dir,
 		*len = 7;
 	}
 
+	if (!format_has_all_entries(buf, *len)) {
+		err = -EIO;
+		goto end;
+	}
+
 	/* parse and set stream format */
 	eid = 0;
 	err = snd_oxfw_stream_parse_format(buf, &formation);
@@ -740,7 +758,7 @@ static int fill_stream_formats(struct snd_oxfw *oxfw,
 	/* LIST subfunction is implemented */
 	while (eid < SND_OXFW_STREAM_FORMAT_ENTRIES) {
 		/* The format is too short. */
-		if (len < 3) {
+		if (len < 3 || !format_has_all_entries(buf, len)) {
 			err = -EIO;
 			break;
 		}
-- 
2.34.1

