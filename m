Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795786855;
	b=T4r84sd7GK9qQ5ZTPgjlynRLvm0oMyW11KFYhgp+5Fld0lgBho+xxwwMAJkKnTo2h6I2
	 Rj8ljlQGLe9Jg9M+GERDXYa6rFSEYCxqjUHWa3YGquJnfPrmYUA2vhhN7ykUUlpo4nrmf
	 6/swcOwfzq7epO1hAzI6Z9L0X14Iu0CesVkkmuEUg4G9hBYWaq42xnzLx2Bucp0CQvPut
	 sm3W6uuRkU+dtnnuszM13jRkLfRjj5vHUcns3+fmgG8WggzGZ1Jkirnj8VrQYhFQBPOKf
	 wCMX4y+XBuz9AHBkdR1z2wwVu7bOZ9V+NePizHypDWSSaUFBEI1sGz5OyHfIfWOUZaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795786855;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=pdEAarPZNKEUfPhFhzlR8v9qpw9OvFlO1VgxWcD8/G0=;
	b=LnDT5wwPjn9Uar+BpVX7NaUS/Rehu8cE5GjwyP+TUMkJ1ywx/aCmRazVzUVzwH8yVwsu
	 sG76dcb1Yspmmnxv46wTpYI1C7klIr7ZKNdgd8i6ujnrAnyAjRdPgCYlSjxwYy5cTLQiH
	 XDIBv+o5cdVddAKr+o4dYp4n/kbvQHsD3w/xheks8K0OMwOkz5mX5fMUe+6sfcZDe1CQI
	 yRLXMU2zSKsdL62MlYlfr3/7t86MMM8P0QDtHCUQ+lxcyDW6P0iWis43cX0TU6o0h3mXT
	 obZL6agO+DRwF2Ut3fZUGSkdLojTh/yjWQg9xfAxnKd4doxsjZfaPqKBr64oEEH6OhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aPWTT7UM;
	arc=none smtp.remote-ip=209.85.210.175
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955D6606A324
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 13:40:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 955D6606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aPWTT7UM
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8b29b83fdf1so4200682b3a.2
        for <stable@vger.kernel.org>; Fri, 27 Nov 2026 05:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795786854; x=1796391654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pdEAarPZNKEUfPhFhzlR8v9qpw9OvFlO1VgxWcD8/G0=;
        b=aPWTT7UMQOIf5lsZVeOWdCskwAJZO+4/C51339LK0ATtZ/D/z5KWJjHtV0IzyhJC3h
         HDFRk97heztJV6zVvyO8OMwjNkJb3ryNrVZ202S1X1JAE36oPzrV3dVCRI2uEP2tVVTb
         cj4HsSP0OUKDRrlQo9DGBS0DysV5pEqshdeerIojoJawkIbGxYiK9ZGFibApzjTmshRI
         DnWIhjc7E+JyXTHeo/nnnGpIdr1w0ika//Eczy0tgTiDYZ7amv1VtB+bNfLblAQHgdI2
         GJ6Qow+UCjRVXq91SyKtuRHPxriFYzAK1oYCoyoL2H5kT6GU0CsahDKtxuh/SV5tf9QG
         3VAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795786854; x=1796391654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pdEAarPZNKEUfPhFhzlR8v9qpw9OvFlO1VgxWcD8/G0=;
        b=l8+EXWvuvTPFxUcGJMMmg0+dC24+iGBEztMix7msHPer3t0lnuwE7GQwt5z+el1JpH
         HKNk1bLGYgZsQTSm9QjXUztGaDfc/fif1MceLJnWqmo28VJ3car1XjWmfTY7dmo19NrV
         Oj6y7ZeTSTPpExybJv9mvWnx1bX2HsbqNUBsOjmW/l9nmeX4KTZrP3inQ4P2u//V4aBK
         0jVszuTggYgrwEqvMtRWmEG3HnYuSxp7Ydf/wIh1eGbzS6BFIff3Lsy3882QSdaG2n9/
         Jo27IyL/ucoKygSOnXQFpgmbjwRBd/lJPuvmQHgqDM58FjGCGwxzPGLoZeFyQPXmMx+6
         b4qA==
X-Forwarded-Encrypted: i=1; AL+hErG6q6eTi+ylzg32YHkUCFlz2zWtaKp8vA8nn6g+jm2RoBOFLjqB/djIXFh7mR5iLbG6KbsYS9s=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Bg5BB4aU3fWEGPfa48PC6qwwcyjECflp79pbttc30aJLqCoBD
	sWOBAFyIU5GZg0kiFnweSfdNh4EpGx0rPzoE6uT+a1dlRHBRmZ1rMjbzQ5rTJmXfvg1QrE2r
X-Gm-Gg: AZFdTZdRIu31ohy83hrP31PtUSvNpY2NTeYcHlBZo2+K1acOT4+/fsYDIZwX63XnKu0
	VN8F0fOvkBdoETf/IWzIZ/P4cjazktIpYx+TkodldjNiliMGwpuQoB78pebDoX6+lb649uMHfeM
	tszg0wt83vkBJGPU15/FuTEhmh7L9ayZgoaGO3eTgK6hjgNgxmzhNSLGqaYdWBWV5u+f4L7FbvQ
	J3Aeqyxzij6SbRJgozRltkuyFJaLNfFji3kWan+/i6JjfjzsgLSWVmg7kA1w6PXOWG+vlevnQYF
	q5fEjCyPrcowWG5r38itcnwfRcT3h1WShSIEU6Ihx9ESpRJs29QQel0tHQvEE8OOLAoJAdsWFZF
	pPFDeSfoTLKr31BQtIi6d46YOcrEjCcYwa0uGriuhIlVX7bomP7OCRFwhTFRlPu2ub4Rx78qRb3
	UJwZqexkiM/jTMK678ymlpJH8E3bVx+Vygf7cgebXR04RFdzJxaHCH/bZNApAh5z5zwXa6Fpk+a
	ldG3ZsJVNYwm416hC4L+S4NVyuCbxbLQ6WjQt2EWw2mzBTRinYDs5+ylyKrQfqFk9a2hjo7BO9h
	MbIW5rNBmNba2QS7eKQGNcBcP1RjS3H2iwjv2ziG//wi356rATDHc3Z1A3RJF2ro7Ivc+LB8NnB
	1ERa8blnHdbIU/rSsFAJK3VHyVuPkFTVVbjssWHoBadIifcxcdLjwrVhnIn1CojNWI3aJn9yxdj
	KDoLnnSZY/rYyIu+iXI2UW1BxPM5pw1w6bh1+NUqE=
X-Received: by 2002:a05:6a00:928c:b0:8a0:20e0:b131 with SMTP id d2e1a72fcca58-8c87bac50eamr22456811b3a.19.1795786853961;
        Fri, 27 Nov 2026 05:40:53 -0800 (PST)
Received: from LAPTOP-3B99V33A (ec2-18-138-229-8.ap-southeast-1.compute.amazonaws.com. [18.138.229.8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87285b60csm12705838b3a.9.2026.11.27.05.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 05:40:53 -0800 (PST)
From: "Bin Luo (University of Electronic Science and Technology of China)" <luob87709@gmail.com>
To: oe-linux-nfc@lists.linux.dev
Cc: johan@kernel.org,
	david@ixit.cz,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v5 5/5] nfc: preserve NCI data status error codes
Date: Fri, 27 Nov 2026 21:40:29 +0800
Message-ID: <20261127134029.1813-6-luob87709@gmail.com>
X-Mailer: git-send-email 2.51.0.windows.1
In-Reply-To: <20261127134029.1813-1-luob87709@gmail.com>
References: <20261127134029.1813-1-luob87709@gmail.com>
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

nci_to_errno() returns negative errno values for nonzero data-status
bytes. Passing that value to nci_add_rx_data_frag() through a __u8
parameter truncates the signed errno into an unrelated positive value
before the completion callback receives it.

For userspace AF_NFC raw sockets, this corrupts the reported error: for
example, an NCI status error mapped to -EBUSY (-16) is truncated to
240 and negated to SO_ERROR=-240 instead of reporting EBUSY (16).

Keep the error parameter as int so the original errno reaches the
completion path and userspace unchanged.

Found by static call-chain audit and reproduced under QEMU with
virtual_ncidev and KASAN/kmemleak.

Fixes: 98ff416f97c5 ("NFC: nci: Add status byte management in case of error.")
Cc: stable@vger.kernel.org
Signed-off-by: Bin Luo (University of Electronic Science and Technology of China) <luob87709@gmail.com>
---
 net/nfc/nci/data.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/nfc/nci/data.c b/net/nfc/nci/data.c
index 3bbebb9..4a2326a 100644
--- a/net/nfc/nci/data.c
+++ b/net/nfc/nci/data.c
@@ -213,13 +213,11 @@ EXPORT_SYMBOL(nci_send_data);
 
 static void nci_add_rx_data_frag(struct nci_dev *ndev,
 				 struct sk_buff *skb,
-				 __u8 pbf, __u8 conn_id, __u8 status)
+				 __u8 pbf, __u8 conn_id, int err)
 {
 	int reassembly_len;
-	int err = 0;
 
-	if (status) {
-		err = status;
+	if (err) {
 		kfree_skb(ndev->rx_data_reassembly);
 		ndev->rx_data_reassembly = NULL;
 		goto exit;
-- 
2.51.0.windows.1

