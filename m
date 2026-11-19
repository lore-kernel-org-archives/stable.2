Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795077628;
	b=DnOLSlpTtHCzKJs0WlI4giHvL+U5Q5GocSTX0Ubt4ZPXz9E8J2pAHx/U2nETNFVA12XI
	 GvW0jQpJLLmxz3ZnV630ba7BhvXwhi/poF3GiG3OEmJIQN+c7129rJWYqazLjpNkpguiI
	 slu5kravawRSsCY+2AcAuNs3G/S7Elf6lrQpoqVVvnCK9tjBdxA+vPyWri3ZqglYrnxyf
	 DhAP5YctJKYlptNQjDu8QfIBQ6woR4gZX/qWtES3PYpEozU7WX5s0HnzSJ3RpotoLbyrh
	 kg5fr6Kl3LHfRzQJr/8XB0F06xwQZ8Wn5m4aojOB0pXcJ+JCYH56023iHZLvWa+D3KQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795077628;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0b0WtnuMp1Hc9oCcX/1wKyrcaG25GmnFWC+LVdfeHYI=;
	b=r1jqC2ZA0/Xp3wBeeAScVi8BxfLsoSxhO9hpgF9iXslZ7NrI459LAHCQ9TmvtoxxUp5n
	 Y2gcpxM/sjfDoNsAMQtaf/7yqcvlQeA82Ayv+QU82Ya2szcjUQdTQQmbi4+7N2WsmuEFI
	 l+znL12NrBT5J2NaXkAN2tLisxyn8HzgMEqcVXcuAeNQxhunGr3py9q4lG9E8v9qbgOSw
	 P18KxUimNjmArsKoLDCQndiTs0Z6OqXApmXx/lQCnM3L+dZv1PHuyPsNrSTyANqK5pYbI
	 AAWKOGQZusF8dCFR/XLipLKCzPWW2dU48nxVFnKapBJvgvGT3lF5zharLUq/d3Cqe4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="W4/UzYv2";
	arc=none smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0690F60A380C
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 08:40:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0690F60A380C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=W4/UzYv2
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2e9ae391a05so4590725ad.1
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 00:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795077627; x=1795682427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0b0WtnuMp1Hc9oCcX/1wKyrcaG25GmnFWC+LVdfeHYI=;
        b=W4/UzYv2xIe5ZLoHSY2yvf69V5U1B4se003ow30pCw9FucMEdSEtvxJp6Nj/xJhprG
         pfNvQYaEdjkK5gWFq/mThHM2m5eS/zmFIxU30re+RWgqshoxPd8kl1QAdhd69Z0w1Ahl
         Kjq5UldcxIK0hcxpUqTGJZHolT5ff5XPXYgrc4BDadRQHP/74AceFiHmDkzAis5P7VQi
         2IGdIO+0LNhcvwT1G640kZQH9KhPoZ0fTMad8UhPR275pMHVOWgNGyCbweUolVy2iYX7
         5T6R0hcCPAscRCXJQSzh9PxzhxynFGJWftp1kZtH80dCLCvTq9n58pfNBYDwiSAhRmAk
         mIHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795077627; x=1795682427;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0b0WtnuMp1Hc9oCcX/1wKyrcaG25GmnFWC+LVdfeHYI=;
        b=WC0tI9qL+BJfTsUQ9LcX3wffWeZoQqyqa/2DzuVUmA5lqCUo8Eg9ycTIAYmwsrNFUT
         yPZIai61wFQg7tclG9wk3tcj9NCYS/CcPsfL9anVPw77M/bbXwJArL4dRcGTsd2nm+CP
         niDq4ECiaUZ6qtDF12gDNqqiyouel69R1PyutJT2Qp3s71r4eBu7KWkmjDWMRu3zU5+5
         LhKv2p14nRfge8oLVEvRf7E9moKshxNPAyD8WJKxUEQqMRYKJwk+jPDgM9HUym+sC8mP
         ZD+75xkWPth5C3gQWqHtwcnJX36f+d4eZwqRu24Zm4/K+02T14aIshdKiKUTevySLy2P
         8JtA==
X-Forwarded-Encrypted: i=1; AL+hErE5itylIccUgIC4xSCkyukxqTXqKuo5tL7IlSmGRDKcsmDA3BZBamdYpeChN9XRhCnEEIPNknI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+xUX/QBK6vaBS50cndmStfcanDa/0wjTuoTHRrl1IuM7chacok
	SsgTEo+zxi6hUdvk7cIcM5+P6WfJDh4i+QZXuMX/IF28xscrlda06BRU
X-Gm-Gg: AZFdTZeixalGztS+94TiFsZZZdd+XFYE8rd0dOjlB416kj39zNhqbSKJrn6OGqNd6Tn
	SLXTaEAgxTgay5ERntVwyoAvGLIM+c77mFf9gqogd45xuhLmJJQZOHl6IP0uzKLSm1+Lmt1nrXH
	sVjyS78JjlRpCXzsI1+kz3IZ8S3VCt0gGQEWMSb6GYUJhhLzeHryN3crlQWgJaZ9wsmDI86VqYv
	01kxR4i/frIlF55Xx8EUTUnd5XKIw7drSdwg6ln2IU9rXsia15MZWwNZml49+ZDEUt/Vo62aEAz
	96hX9gYuBFcC0gbt9DLQPvu2okK8z7zieJw+xdTnoa+Vkygy8zJ9UuV043OPZnmM5DVeaUtDgnQ
	WMHX36VGaoIuj7hGiPkQmOGSeFgz/ZrpqQa4wL72GBC/MiV76giv/vWepq1hJvj4AKcf6c5qe8G
	HVagsp5QI3fsinRSQ02f9jlurxCjbTitYQ+2CFhtgnOgUBrwXgbyLpZ4IKJo/Cn+bR8dswadHBj
	UZ5XU4Jbvht6EszQVTKacZ4DT6r7awYY/L1Et+zQjv2qGGE7BEBXbstWmXWRX4RfwGmno3tR8In
	rQXRnHLrVJm/HJvqtzE5Krbv5RZ0c/6rJG2TYkDwgFQqxKDKT0yoUeJBtSy4lrK6pG0Zjw==
X-Received: by 2002:a17:902:db06:b0:2ef:db5d:59a6 with SMTP id d9443c01a7336-2f031cc67ddmr3577165ad.23.1795077627055;
        Thu, 19 Nov 2026 00:40:27 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eff62a9d47sm27425995ad.69.2026.11.19.00.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 00:40:26 -0800 (PST)
From: Hyunjung Ko <hj351016@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Guido Kiener <guido@kiener-muenchen.de>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>
Subject: [PATCH] usb: usbtmc: reject a short READ_STATUS_BYTE control transfer
Date: Thu, 19 Nov 2026 17:39:59 +0900
Message-ID: <20261119083959.1599898-1-hj351016@gmail.com>
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

usbtmc_get_stb() asks the device for three bytes of the READ_STATUS_BYTE
response into a kmalloc()'d buffer and only checks that usb_control_msg()
did not fail:

	buffer = kmalloc(8, GFP_KERNEL);
	...
	rv = usb_control_msg(..., buffer, 0x03, USB_CTRL_GET_TIMEOUT);
	if (rv < 0)
		goto exit;

usb_control_msg() returns the number of bytes actually transferred,
which a device is free to make shorter than the three that were
requested.  When the interface has no interrupt-in endpoint the status
byte is then taken straight from the third byte:

	*stb = buffer[2];

and the caller hands it to user space with put_user() from
USBTMC488_IOCTL_READ_STB and USBTMC_IOCTL_GET_SRQ_STB.  A device that
answers with one or two bytes - with the first byte set to
USBTMC_STATUS_SUCCESS so the status check passes - therefore leaks one
byte of uninitialised kmalloc memory to user space.  Both conditions are
under the device's control, since it also decides whether to expose an
interrupt-in endpoint.

The same leak was fixed once before in this driver: usbtmc_ioctl_request()
bounds its copy_to_user() to the number of bytes usb_control_msg() reported
instead of the number requested.  usbtmc_get_stb() cannot be fixed that way
because it reads a fixed offset, so reject the transfer unless all three
bytes arrived, matching what usbtmc488_ioctl_simple() already does for its
own one-byte request.

The check is not limited to the branch that reads buffer[2]: buffer[0] is
consumed on both paths, so a short response leaves the status check itself
reading uninitialised memory.  USBTMC-USB488 4.3.1 requires the three-byte
response, so a device that sends fewer is not conforming either way.

Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
Cc: stable@vger.kernel.org
---
 drivers/usb/class/usbtmc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/class/usbtmc.c b/drivers/usb/class/usbtmc.c
index 51cd9320a736..c5b91a446a72 100644
--- a/drivers/usb/class/usbtmc.c
+++ b/drivers/usb/class/usbtmc.c
@@ -506,6 +506,10 @@ static int usbtmc_get_stb(struct usbtmc_file_data *file_data, __u8 *stb)
 	if (rv < 0) {
 		dev_err(dev, "stb usb_control_msg returned %d\n", rv);
 		goto exit;
+	} else if (rv != 3) {
+		dev_warn(dev, "stb usb_control_msg returned %d\n", rv);
+		rv = -EIO;
+		goto exit;
 	}
 
 	if (buffer[0] != USBTMC_STATUS_SUCCESS) {
