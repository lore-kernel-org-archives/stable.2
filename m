Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794954012;
	b=UhDcD+CmV/+RzssDHiU5ecD3tQVIATjP6OQHSfpV4kdnX8APWhG19tXuMi0QgPIdYpxF
	 FBB2i1lSSMDtmBD1INtl1sKVLSKWt5iXk7qoWpx4AHmwFXFKRdTu2Y+ft1/3u9h+glwbZ
	 xxIFRceBFtwNR0KKQhR44K5Fh7QYIGC6NI4t/osfHVwLcI0zmoQlfk6MBUZLqCXFqv4zx
	 FhxFcbl0SQiIIECQIBq0eFBmezZy9HOd1EALWgUWah+JIiULvT/M6KCQhBT8KUoERQGrX
	 aVBMNfV0neO1jslQRbWLSP3kw73yAQ9cwIgBbGuiw9Sfk0fmsKctKd08vtDryEg809A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794954012;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=WflaroK/HdnKLkiYlRX4FEHj2IhQFQVWvSt+QcA/ajo=;
	b=jgKIsclzvIfM9Nlz4DUH3dKmc165wNKF/F6E80bUtbK/7Nx0AhyY6r5R0kH4ytLFciNg
	 Y4jiqvlILgH+JOQl4BN5B+6hVng/KSaNpPAEiragngsvJVnU3z4agScHuYp0riPNwO5V/
	 39wpjmAXCjD15SHlyrhCf75BSGJ/uHbLa0BKGGA8Zg1/CCO1ERsajcdoFxP3ddK7emCn+
	 2zzr0cIvFNCHiAf0TKyWbOHt85lH5qn84lf+Ur8rtbXY+dEnANd/b5crwG6/Ek2I3jUk8
	 7bgdPzXZxSIp8DIiqmLzdC8Idp3RpnlwnBFl8L2hJF+iJYrxdKw03fm9frNnPupSA4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QZNbf56h;
	arc=none smtp.remote-ip=209.85.161.44
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710C3606A32A
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 22:20:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 710C3606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QZNbf56h
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-6b8e2d8df4fso231207eaf.1
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 14:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794954010; x=1795558810; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=WflaroK/HdnKLkiYlRX4FEHj2IhQFQVWvSt+QcA/ajo=;
        b=QZNbf56hHyO8lX5U1PPnYEQsUhlTqLGK4GEjkptna3rW9ChxyPm3Bll7oWHHu8hV1T
         RJx+KlhG5LQdb+p3UhBhHX1tiWVE6x9DHuPUP6PALV+Tno73c1cNOsYhJNZWJJlvtwbI
         TZR4q+tSGEBjZ2Pftga23cmxE7UKRlAF/SubjwecokI8fZ5fpH34bUUIk7qrLasS8NSw
         HzqL6RjVhiLljF2K7YqmOsE28+UJ/MUVlRqiWJef1p0DdXBk7S/Bhfu8+1qNmrZxKHKc
         4jp0tTv4C0kg/kT2aWdeqLxf1X6/TUyiMm/OTwQhd/NcB6jVu4ZWYroozX9A/lNjTPe1
         hYWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794954010; x=1795558810;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=WflaroK/HdnKLkiYlRX4FEHj2IhQFQVWvSt+QcA/ajo=;
        b=0VrLD2wjW3frZA2/P+HjQM097R9hFwr9Fy9kL1UyjiBTt71SmojqqktVWaVRy+ISZk
         Uzsy7Pq2BS329ZNRNbGReC3jAEe34SpgT2wlE8mNviubsIB6MQvjT3g1ioGdCQlc/28c
         wO/V3k2gG+m30kWkj1V8Rm5HVgmWpLVoZMZhEDoKgVl7Xrb4XM5RfE9bEh+P3RCSvLFw
         lN7H+MXcORdIMBtWQyFMFzxKfhvUVZgEPQw87QnqDQcQ/+57cR1I+nu2pTHrUevDawDX
         NN6OYBPW2HpFfZIUeYnb21ZaG09ammUaLgdmmL11uqviy8W/QzQa3311WnoUmqDNew/Q
         IZrw==
X-Forwarded-Encrypted: i=1; AL+hErFoSRzIfmOx4k54FaWwioWjh8MIj/hTDGFHVA+26XgoSFvqC7A6tUIV/RH9HAgt+4c7J3R4Rm4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+oWcDngoltuVMlRe31/8CekW+dsT62i0zn6B3sGtj1Ru5TWVwa
	Xewg6Bp5EFf4AV3zkqI7W5067khT3SCea/btdi/l68/yhbS4f7KIQHJS9Clpx3Wk
X-Gm-Gg: AYBFou1c2+991r9yzhPzhSx8oVAZkZIsMEUr0ZeyV0Qzw4T41dqfFuymMOwWAGnDRry
	pF7wBB+1CEfReGxpUtgGvnhrosap/vi1HFLIqXASQykgPsW+8w3ngryFBAtPytIG5MfKW4dgreG
	7le0KFTIqIYiLsMEXGZ0Qxp282qEcNFeo719goa59Vw7nfJwTy1h9eoUhfJT0CrpJKUiv2cupk2
	vIzTme5Ei0Q5fKThEZ3sbxQ3L8XuPsntLEfCtRN1qL2wdvzmcPD6Ec2bgY3YV1KZhDqSkdlQK+P
	2JVGsPzuuIJiBFQA+V9Mow41Wj9+kYuwl9M1YSgCxCPMbAB/im0r74TXkQKRRPiepzDuEwvHxFJ
	NGbLVYJKMohClgHm9XXpAnGp14efZld5dBm+90B3HRu66JQGuwPlIlams9c6k29gHT0mEFyF1zc
	qO4Nhdnfu7WtypfgDbWssioIgdL4Y0O5OTvGyHYOjZTxqMU61nyj0EJlo/1A/K6QfuQp4CZBaWW
	vZVNWusTWFcxsM8/eJNSaVwQcKOVENF+SYFNqDSQd92zzeymkW/nnh6C5Img4NlKLTD1BeQ/qOL
	lQFtOD7/Fwmh9Wrl520k7XtRAsuUNBDth3PTQZtzVM3yVgIWZahKWq+y97WW3HnlAv8X41CLrQT
	eSpsHHRycVR2fGwjtmohxrwTFuWeZYV8moZevSkeCMyZDO9DDIjS1GbXlGPmdvJ1srtpg+JM/vD
	rB41kYByizEsCifdRGbCN0ImtUpMH1JAfS9hV5Ek3Twtib9wNlD/t+
X-Received: by 2002:a05:6820:5051:b0:71a:de26:e969 with SMTP id 006d021491bc7-71b1863c5f5mr559712eaf.48.1794954010315;
        Tue, 17 Nov 2026 14:20:10 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-862f021aae9sm577548a34.18.2026.11.17.14.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 14:20:09 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 17 Nov 2026 15:19:45 -0700
Subject: [PATCH] nvmem: layouts: onie-tlv: check both field header and
 value bounds
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
Message-Id: <20261117-submit-nvmem-onie-tlv-bounds-v1-v1-1-2b114f1153cd@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/y2O0Q6CMAxFf4Xs2TKHBpVfMT44LFCFDduNkBj/3
 QE+nvTmnH6UIBOKqrKPYpxIyLsEZpepuru7FoEeiVWxL0pjzAkk2oECuGnAAbwjhNBPYH10D4H
 JwNng/nA8XmzdlCpZRsaG5rVwvW2cFE+sw6L9LxjfMaXDNlP2LknLiFXWhTBKpXVLIX8hO+xzz
 60eo9VSD7onF2e9HZaNFiZHev0uT5w1nmHr377fH65AChnuAAAA
X-Change-ID: 20261117-submit-nvmem-onie-tlv-bounds-v1-81e03449bcf6
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Srinivas Kandagatla <srini@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.17-dev

The table CRC does not validate individual field lengths. The field
iterator can read a two-byte header when only one byte remains. Its
value length check also counts the header as available space and can
publish a cell extending beyond the table.

Check the remaining space before reading the header and exclude the
header from the space available for the value. Stop at the first
truncated field, keeping any complete cells already registered.

Fixes: d3c0d12f6474 ("nvmem: layouts: onie-tlv: Add new layout driver")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/sashiko-outbox-219531@kernel.org/
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/nvmem/layouts/onie-tlv.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/nvmem/layouts/onie-tlv.c b/drivers/nvmem/layouts/onie-tlv.c
index 4da3a704388e..1e397565b928 100644
--- a/drivers/nvmem/layouts/onie-tlv.c
+++ b/drivers/nvmem/layouts/onie-tlv.c
@@ -110,8 +110,15 @@ static int onie_tlv_add_cells(struct device *dev, struct nvmem_device *nvmem,
 		return -ENOENT;
 
 	while (offset < data_len) {
+		size_t remaining = data_len - offset;
+
+		if (remaining < sizeof(tlv)) {
+			dev_err(dev, "Truncated field header at 0x%x\n", hdr_len + offset);
+			break;
+		}
+
 		memcpy(&tlv, data + offset, sizeof(tlv));
-		if (offset + tlv.len >= data_len) {
+		if (tlv.len > remaining - sizeof(tlv)) {
 			dev_err(dev, "Out of bounds field (0x%x bytes at 0x%x)\n",
 				tlv.len, hdr_len + offset);
 			break;

---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
base-tree: https://git.kernel.org/pub/scm/linux/kernel/git/srini/nvmem.git for-fixes
change-id: 20261117-submit-nvmem-onie-tlv-bounds-v1-81e03449bcf6

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

