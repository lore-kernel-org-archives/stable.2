Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794244905;
	b=TrrCr0FDFNcmJIj5cNjDZpwSc5RnLzu3rt00HYk9ZbU9tkTtcrU6lsJ20MeJ3dQlw8qp
	 twHLyQXnMW4iNbpk0QHXZgrmZBhavPX3oS80xrXN/iq77vHZX1ObJPhsWgHJvvgmJ5SZj
	 E56F+uwLrjfhZxU+GuDboTJNk5UH/ddnfdUEVJAzl3D8iasuoTEPAaXY7FWiVuKGv7sid
	 vVSTSGy0v76Gw/1wXNWCu5Yu3wZ38bqwUvU4/UxlBZtUqtfmBbdNdpfp9sM2yBHHBSND+
	 S3XwfPWMyBKNCNg/VOFC35U2Ljwz97mWco04dfoPh3rDJsmeTSQ3MXyRYWwXcVSvKYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794244905;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=EYatP+6kphd4sDxDGzxqCkF4Bitbwr9mDBucDIlhFks=;
	b=D818MtRxhg2VM9WQf3VyPYaeM5a5P9+XhsiO9+pMLCPwAhgZ49LdS2qiBw1V+vQlXQhG
	 23zK2G6W5FpxxD9d4pRHXDHJPNh8HIi6DMW3twgHDNHvqZGzxKEYbWC5uRc4u0ernKEFi
	 cn5qGxrErZotnNx1w+PDfCNBmaGZbP2PZcjLi2I+x9/JqvdlXNQOM1urLXS06nELCC6Im
	 azkimFhxEx4RnuYBncdRkZvkdUCIu6ZcPpcjxLrusAEsQxguFU03PHKLonCb68upr3aq4
	 aQ4aWnRrhAiHUQTFHss9M6YWJTFfXH7bqZ0XbkWgI1Xm+Ca1PlivVunjPjjbTLzAnDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VlUjpfwF;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56886606A321
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 17:21:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56886606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VlUjpfwF
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-36f6295304dso1424237eec.1
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 09:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794244904; x=1794849704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EYatP+6kphd4sDxDGzxqCkF4Bitbwr9mDBucDIlhFks=;
        b=VlUjpfwFh7SM9knIKPWquQkjWd4L0VGLqKxIuu29C5PXA8aus5Er5PaTadj54NB3KX
         JRQKh7kKzcFc8NMkgL+yz6tjt5vD7rQSewpK3D/mcZ2RVDbFxxG9ILW1ohvgF/zcumGe
         34RBYBy6ZDuplsxD7JZBNyhXRtL/SnR3LQkEe7UnMVTfLTck27ow+POHGdmhcgX3G9Er
         r/rtmHeXiLH1EB/hO1ZFl0PPbnqa5e+wqxnxRZTz1FnRhNq4j4A/rQKczew8tskUFI41
         PPQsZQCJFOiS4dKpyo+5MMishhxhUwEBx62B9WseyOguFbV+CRSXXpH5cG65zK5ezp7R
         ReEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794244904; x=1794849704;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EYatP+6kphd4sDxDGzxqCkF4Bitbwr9mDBucDIlhFks=;
        b=YWCrDyFy09OxjmVH9w5fOmsqM0zWhlru6mgJNRP9ShBOuEeG7+2eldTnIZKjUkJmaE
         hg+Z0sjW8ya6OA3pEUIQ13FzAuAiPZlpe2LA/46ePZAtSOELav41gSA9A8JqSy0YsJAf
         d9IYXzIZpnFEodxh78LBLddv95dqUGSSGFGKqqKirP2T3JmhaxqniEwFIJ6x/s+hnhOr
         9Ni8vO5cJQ0o0CMIeooJ4FMplhZo8O6M3vVrKFkBNbwEvXiRW9hNxuRmgcyxO9IR9arE
         4TuWKXrcRVT2/VcMtUemBdNO/zCISnXQLgWLlgzlCb6FMAelZbs0QYDv+P7QFEyt7ixV
         j5LA==
X-Forwarded-Encrypted: i=1; AL+hErEDtkP6+f5PWZNdyHirGGAb9mxkI4oQgDUtG+eRGxO6SjwDX/bS7Q5uFsIdaXxn3rTqm5bqRe8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8TgSqm30nTX7bj+mlFsRU6rs8FsELxFpu/mF+43XrH6rajf2Qh
	+94106qumIVqVkT62yeLWRCgeeMqDZQieJmgg1azPA8ItHsgUDPeIJOa
X-Gm-Gg: AYBFou09OEwA6TJJIl/6KgysNpiQ5rjOjIMei1gx3rEHKowfN8NOEE2a7C8Okz/VQVm
	yZyfq733y1jWElEhb1h6Yh6Tqslg/0lClaz2tjy5dyag8gprxol8eD8MySro2gXOmTfpyw9PlD5
	sF/nFAcFDOS9mRlP6BHGigknWcp5EQ6q+j2D6LJus5GibPMz06EG57rZTVJju6sMAgd4BWvP22O
	SZvMKhRJIEo8e5LVvAuhz85IGJGFYXppqILOdu9bwMPCUU+2JBYKJxRHLqwp580zmnfco7IodvU
	JFfnf1zCwcctu9JLypIrrTO4U517lCZK90W3S5vKnYdlsaGfZju7GhLY3m960NkOqW4RH0JcomI
	8gC7Sg8r30tAus1ADBFPevf3G1VLRUtIiXLjzbs/4Zeh/u4jjrqgfl+Li+0rfGWCh8TXZ8b3zvp
	jSVqOIG+KTs7fQS/ASQl04tXNddhcuo3ob7+E86ymRfiv0sVgusIOAfPKMaibNiZ/mORVGQrQyV
	zDkHH1JwEpFsyNwY6ZN8Cc3uAU4at2YgtzTVoDBGbK1CRv9T/EK3WcD1grolxzwh4NtD5YPZ5pa
	by4+bXc4pcvjwzJ0qhwq3XxkaHKifI+9QyySl5goJsQ+NbC+
X-Received: by 2002:a05:693c:87c9:10b0:369:ef92:bd7b with SMTP id 5a478bee46e88-37257c94c98mr8368198eec.41.1794244904244;
        Mon, 09 Nov 2026 09:21:44 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-372665db8bbsm13069322eec.22.2026.11.09.09.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 09:21:43 -0800 (PST)
From: Hyunjung Ko <hj351016@gmail.com>
To: Oder Chiou <oder_chiou@realtek.com>
Cc: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>
Subject: [PATCH] ASoC: rt5668: cancel jack detect work on removal to avoid use-after-free
Date: Tue, 10 Nov 2026 02:21:34 +0900
Message-ID: <20261109172134.1850973-1-hj351016@gmail.com>
X-Mailer: git-send-email 2.43.0
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

rt5668_jack_detect_handler() runs from the delayed work jack_detect_work,
which is queued from the jack IRQ handler rt5668_irq() and from
rt5668_set_jack_detect(), and re-arms itself while a button is held. The
handler and the delayed work jd_check_work dereference the driver data
via container_of().

struct rt5668_priv and the jack IRQ are both allocated with devm against
the i2c device. The i2c driver has no .remove callback, and the component
.remove and the .shutdown callback only reset the chip; neither disables
the IRQ nor cancels the delayed work. On unbind devres frees the IRQ and
rt5668_priv while jack_detect_work (or jd_check_work) can still be queued,
so the pending work then runs against freed memory (use-after-free).

Disable the IRQ and cancel both delayed works before the chip reset, and
wire that teardown into a new i2c .remove callback so it runs on unbind,
mirroring the sibling rt5682 driver.

Found by static analysis and code review; not runtime-reproduced (needs
RT5668B hardware).

Fixes: d59fb2856223 ("ASoC: rt5668: add rt5668B codec driver")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
 sound/soc/codecs/rt5668.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/soc/codecs/rt5668.c b/sound/soc/codecs/rt5668.c
index 0000000..0000000 100644
--- a/sound/soc/codecs/rt5668.c
+++ b/sound/soc/codecs/rt5668.c
@@ -2566,9 +2566,19 @@ static void rt5668_i2c_shutdown(struct i2c_client *client)
 {
 	struct rt5668_priv *rt5668 = i2c_get_clientdata(client);

+	if (client->irq)
+		disable_irq(client->irq);
+	cancel_delayed_work_sync(&rt5668->jack_detect_work);
+	cancel_delayed_work_sync(&rt5668->jd_check_work);
+
 	rt5668_reset(rt5668->regmap);
 }

+static void rt5668_i2c_remove(struct i2c_client *client)
+{
+	rt5668_i2c_shutdown(client);
+}
+
 #ifdef CONFIG_OF
 static const struct of_device_id rt5668_of_match[] = {
 	{.compatible = "realtek,rt5668b"},
@@ -2592,6 +2602,7 @@ static struct i2c_driver rt5668_i2c_driver = {
 		.acpi_match_table = ACPI_PTR(rt5668_acpi_match),
 	},
 	.probe = rt5668_i2c_probe,
+	.remove = rt5668_i2c_remove,
 	.shutdown = rt5668_i2c_shutdown,
 	.id_table = rt5668_i2c_id,
 };
--
2.43.0
