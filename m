Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795164060;
	b=y+ff/OZ4RYaq/4lbji0QOm5Fj5ZQcuYGIXpQV2JBAQMdNDwhZHDGD9J51tVVz/zqRKoT
	 of3h0UsaxHGkn2+liok9wp2RMQGdfcOfJvA6FV0FTPS4xVdsYZWGVuJMfXQKucPtzh17r
	 BZEkHgN8dKrNUXCQEFs21/Ahk5K3S9csgN1v0LINYvN/YT2q0Nav7MkfBO+u9ZbFmY94J
	 7F89lUtwCJ8eOs0NkShz6xRna91xsy6VeE1NJs/ScppfP0zvkO9zlcHxTbY0gn1nPU7F5
	 LhNuSf41WdjImT9HAp5FKFNJGuGSG5JL7jNMPenur7zRV5/7GJG29lfT88xmE63TG5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795164060;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=PUXUXXOO5iNBSWhR9dVDhL+xLFTr0pkbQo+C0Dqwezk=;
	b=IuEEgyU/g4Z96dtp5kNY0syZQREimnWxpJlnhVn8uhvIaUeAWODUI/sjyooB2e2rZDBz
	 2hX00SykmNX5s/g2M6ckYqixvNB7W/l6lbVSA5cUz2U1CbBIsI3UNaTHErNxNA7bCARqd
	 YE86XAAJKsA99z1DVf+SUwlloNwZ7CJQzaIuWW/zOlkCYR0e9uEgFIsNaIauVMqGlFUZt
	 sj3zehtVW2mojvPqIFL14g4pS+6ZwckW2j70DcM7qIeqXTMNTj8c3ch2BMDUdKCo69BBn
	 JencJz+cFBUvdQrDIolI8QTX9eNRqZee0yRAx4qyzKpr12Re2KCHHgXVD3jI6kMt6Fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XwuvkxuJ;
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4326B60A260D
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 08:41:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4326B60A260D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XwuvkxuJ
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1b3a05f8b5bso892997c88.1
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 00:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795164059; x=1795768859; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PUXUXXOO5iNBSWhR9dVDhL+xLFTr0pkbQo+C0Dqwezk=;
        b=XwuvkxuJZSWwDhEkBjSfmCIYGsCXQ7BuuRgzQxRUnw61kCKpn6LU3ucPcwcZE7bRmA
         n9ajyBH+Agv+YxQaO+deWUiXo+KmtdUmgRfebphuUBq+lgMWG7d684VVWw+HEwalRjPb
         KCd569zZAweZvWsCaneu9l3/FFTelaj67v2fuz7twfjt9GGvypvaZdshvoYQVxE1AClk
         dE12pOIxIsQlKULmrmh7TlV3hgtYz9vsHoQaz7Tazm83YXUwwmh5hzeylfvD5aITxMPv
         QhOv6Mnehxzp6wGGS+0zwHvsHrRvBOvu5LLr7I4xziV0OLIGXXtL6yDsBnCRhKrT3pPO
         Wm/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795164059; x=1795768859;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PUXUXXOO5iNBSWhR9dVDhL+xLFTr0pkbQo+C0Dqwezk=;
        b=hY+HGh+VlDbXXIS9cm9tRomwwryaH0PSZWldTQ978XcB+xb+RzyzOxe0ACUPVG23QM
         tCs6U/j9rmS3fqwbC3iMZSo22Om1yjoMinbzFftiu8DkF8v2CRhoIQlWKn2EVXy7aQp/
         XQnfVjx9hVr+lhL1uF4il4KJ6Tvp9mMWpPp+Fa3PEoH3LyxgDw2pMfqi/kxTAn1OngH0
         aIjiQKHA1hGmpOrMsfkQr9TcjYFF1UCIJTgmjYQE9oRdV7ZrLBk7jOtxh6qW/rVzP4+3
         F5Bam5VjDLOS7KNCd31KHzrvYBlodroGbQFSzhDEqxlOcmkQWV2uu4R7b8jPQ1Dja71d
         qlQg==
X-Forwarded-Encrypted: i=1; AL+hErHLSbLERZtBYSqOFTqj9bCN9gTjxNh3ez6T8AO+lNLa+JhB3kwK6zC9+Umb0kDAPI2W0RibJpg=@vger.kernel.org
X-Gm-Message-State: APuU4Z///64SdlfvjEqIA6ve3TvI1xR3dsFPpV2bqw9oTW0X0X0eyaeb
	8shVhHJTLQxZW09+jbxoWay/KWkwukyMKL/mqk2WOR6AI6+e/jxURyuq
X-Gm-Gg: AZFdTZfOjclCrGqsdNFhBoFxcmytm3GGyFQaxwakypXePzK1BFxHOjmD9q2HlSGoJ+I
	7YuUct24Bq71IkTjK9lxll2qXNO9if2wMxH1HAazgTKQz7o9AKpQqmzB0edUxy6hJuQDJWEO+G7
	3B1zoMQBrz9nucfBB31pSHOAXDn7TRLavpQD+k8GBCiHxwAtfMEIPOAw05MqNK+j0hJxw1D1wPY
	f6Vmd2+xXT2/t8nl0NCMjZRxZsRKD5SBYVZ18uQxQA1jnZVkB7MNNetg4/igbigZax5bPtjabF+
	+EzBrLzPmbynSd1nG+pGcxJwN+5tSIb+PSHzDK/ZDAOthPMYdE+nuzLGVSh8+So6LntIsSS1123
	LJxiLK3eNfpr6Oo4Ls+DHy5LjMY6PAqBO/gNtEHM3vXZivZCsAbqTcOhdAbUVXit8mDhHq4p1QX
	9mUK/uGoxjZBjrh3YP0J7lqsjqcWQUt/Mi6rLovgUU1zCI7ICWA0iESKzqHbkxVmmF3MjbQB0aq
	tBPyXqvVEgfmFQYZx92Mj+E3YcIGQlrzB7XOhcz/78SgbzzUDsqga//7Km2NKqTaclhuy9T+QJJ
	qdMOBS2lDyyhGK4HPP+Unj4nl5k3m/BkDlNMBQE+cZDqY3f3A+jKqRAwFa7X8YU5av3uWDh2d2j
	gpmXfxYkdgM/6jRzvvQ==
X-Received: by 2002:a05:7300:c01b:20b0:385:4b9:18ea with SMTP id 5a478bee46e88-38571027a68mr2361900eec.35.1795164059305;
        Fri, 20 Nov 2026 00:40:59 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:ea97:e47d:2ebc:210c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385677c371esm5793181eec.23.2026.11.20.00.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 00:40:58 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 20 Nov 2026 00:40:49 -0800
Subject: [PATCH v3 01/14] HID: logitech-hidpp: fix G920 force-feedback
 initialization timeout
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-hid-logitech-hidpp-v3-1-cfe2caa1d0eb@gmail.com>
References: <20261120-hid-logitech-hidpp-v3-0-cfe2caa1d0eb@gmail.com>
In-Reply-To: <20261120-hid-logitech-hidpp-v3-0-cfe2caa1d0eb@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Gideon Heinz <gideonheinz02@gmail.com>
Cc: =?utf-8?q?Filipe_La=C3=ADns?= <lains@riseup.net>, 
 Bastien Nocera <hadess@hadess.net>, Hans de Goede <hansg@kernel.org>, 
 Edwin Velds <e.velds@gmail.com>, 
 Stuart Hayhurst <stuart.a.hayhurst@gmail.com>, 
 Andrey Smirnov <andrew.smirnov@gmail.com>, linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-6b8b8

Commit 544315e40172 ("HID: logitech-hidpp: move FF initialization to
.input_configured()") moved Logitech G920 force-feedback querying and
initialization into hidpp_input_configured(), which runs during
hid_connect(). Because hidpp_probe() calls hid_device_io_stop() across
hid_connect(), incoming HID++ responses from the device are blocked
and g920_get_config() times out with -ETIMEDOUT.

Temporarily re-enable HID device I/O around g920_get_config() in
hidpp_input_configured() so the hardware configuration queries receive
their replies during input setup.

Fixes: 544315e40172 ("HID: logitech-hidpp: move FF initialization to .input_configured()")
Reported-by: Gideon Heinz <gideonheinz02@gmail.com>
Closes: https://lore.kernel.org/r/CAPb1+K1-pirdLGZ1wTUw26G6pvhg7rGP3QZ172ys5DB7rNCf5w@mail.gmail.com
Tested-by: Gideon Heinz <gideonheinz02@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 60fc6b86a085..85d8d168ff15 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -4096,7 +4096,9 @@ static int hidpp_input_configured(struct hid_device *hdev, struct hid_input *hid
 		if (!list_is_first(&hidinput->list, &hdev->inputs))
 			return 0;
 
+		hid_device_io_start(hdev);
 		ret = g920_get_config(hidpp, &data);
+		hid_device_io_stop(hdev);
 		if (!ret)
 			ret = hidpp_ff_init(hidpp, &data);
 

-- 
2.56.1.750.gf70dc682cf-goog

