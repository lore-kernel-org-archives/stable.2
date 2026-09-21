Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com [74.125.228.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFC143CE51
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 07:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789976529; cv=none; b=ttMV5FZZ/8JRdWMWjW0Mxax8wrm3viHZjC7Iss3sb03N6zyVssVPBKK5HBPdhitCPln6jw0NAICl44AzvBaYki7cWFb/dhiO7l/ZyR1Dj+tLhLoM+/c2S79vjIAnkBtbHBcM8IPZ7vRDwCoQvdXxHhtcOXJKnie02mQPy/n+c9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789976529; c=relaxed/simple;
	bh=YsalEVAYHaGbe1Dk1lXHVV/f9d6wzLYXlYSBHBUtllk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZLkbqdMRqjPy1k7WrFemveyxaW2r7xvxbi+1tzlR6BNT/RJ1iBjA2iGfra8PMAuFblvbEDTB1g8g3u0qAeW6tK6zp3rOV45wLIsjTZbujbuRlWKkwp2lhkl5ewK8H4P9V2/AfQY/SvcRA3iZDMVOII0kyZNyNXi2bI/rTbc6JkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A9Tnx033; arc=none smtp.client-ip=74.125.228.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A9Tnx033"
Received: by mail-pz2-f40.google.com with SMTP id 41be03b00d2f7-cc515bef69dso1707035a12.2
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 00:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789976527; x=1790581327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pGVEYz9jNs9cZq7gLpR3QmqEUgHVWJ7e7Dw6gUYLlpw=;
        b=A9Tnx0332d/SEN2nWTvHGWc9IHiBvg9mv1xWG4i6dlGY01iqpyluSwmOgX6j6H6rzA
         CqYrAF3hQCTprK1qnNnqgyQ1XJcWtajWxcPztZzrcjVC68XDuSqrii58HJWA2QfqCHBI
         rSTytd7Tr+fAbW/yvv0EQx3tdUONpoyiOKP/jPS2udPVmNVsSJ7uf+lYuwnwwnttJRiX
         ppPm9X6qTr6O/BlREFDQmRSqna24fB5IsqHhr/z1sWeuqyXxrhpsRqCCkOG88MbzGd40
         IfMuiHgKM/MzMu/JOVr5H6GaN9Yd4v0pbx3NkIS7ttmG+KGq3I8Eyj+fg/ah1gG8jLdY
         4ojg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789976527; x=1790581327;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pGVEYz9jNs9cZq7gLpR3QmqEUgHVWJ7e7Dw6gUYLlpw=;
        b=DzOp4Wy9lTrv1k+gtM4jlw1vimtAEYGwkFbeGCS5nCNcJqKbsIFLEI2oDq//Ai8pNn
         ZCqme9jUwMa1QK/evr0CPYMszpyGtVOWTiNvJnb7EZZHhwq7cbkM5UfU36YRnvALb5/a
         z7KkNZ1YyJjsoCvhEs563Pcp864MO0SrzVh4/zkI/8t2LihZD2ki2JREXtlqD55yEPlT
         dCp1NsfFMqXHB8VUJfUQu1jjUgjNUaS346vbMuPiyzFevGwsnqfoVuLEf/C3ki6svq0o
         xLRoWtVujFszFWJThzEZ1eBej3T3oDsu4PVjrjemVAbZTEZqzPC35Nx17rzB5wzXjvbh
         JWaw==
X-Forwarded-Encrypted: i=1; AKwUvBzp2QDu7tRhbBZNqh6cUQ1hthxIfqfcjp0XH2x5h4d5mDaTVoTBt+Qj+Eq8AnXJJry5SMVDfD4=@vger.kernel.org
X-Gm-Message-State: AFuF++kyepEEoRN884tGSyyBIWDrj/Nh1AYBmYyqDqZYW3mAk1DsCB4O
	cJQDmoBJAeyb4vOURYLzOV2/nOw4BSKkK4U308/DjCg0/US4iSxGo2uz
X-Gm-Gg: AYBFou0eF8LQA2Cto5ZCKEyEI859UQZeEvU+pCTi6zpnEIWWdS5FBOZJ4QY/GbTDHMa
	GUkMsVrwIl603jvGGS8MI1AIzgMq17pfiU0DLaV9twb7+aGKNJLSfE8y7ZKR0TRZn12HP2YoSai
	R6IP37CaLt2106YVtKWCqh+Zv5PnaXnx4NWW2ymw53Tpz6m4sheAt3AAdtgWoNcI9KN3Q5XZy11
	ItT1N/X24MIeSTnKlAbUXndGKZmHv1NgwnAEknvtvHVk8qZ+w3amb6AWVaXw6l92u5Dhs8IFwQr
	E++Qj+iLPa6T8sLMsCkUrvlXG788ds+11NivfFDcyqRsfJkpfjwRQusmxapbOagFLhmx73P4LL4
	SbuPCMLkzf6bnO7TqkoymmzDXppxWjjkAhLl+HFmSh0Io13RuVxlIijSanf9I6h3EJYNo++ZwCB
	+ORkKnqJ2uV6QSJcHLC/M21HzAxtQC5Y3VqBbwuPjI0X+qPfBOgTU7cV7vFeIsl0lFWNwMk3w/m
	mNwXTKuJFVNNGpuC9FJx5QCRqHyxsWlKL6Ex0AljdS5RUSctXxvZYnchFzCpqpPw5ShtwLEVdYr
	CmDderTYRQ==
X-Received: by 2002:a17:90a:d00e:b0:39d:fd82:de0c with SMTP id 98e67ed59e1d1-39e54aeed0emr14253187a91.2.1789976526598;
        Mon, 21 Sep 2026 00:42:06 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6cabb771sm13015876a91.9.2026.09.21.00.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 00:42:06 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: Harry Morris <h.morris@cascoda.com>,
	Alexander Aring <alex.aring@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>
Cc: linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hui Peng <benquike@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2 2/3] ieee802154: ca8210: prevent stack buffer overflow in hwme_get_request_sync()
Date: Mon, 21 Sep 2026 07:42:04 +0000
Message-ID: <20260921074205.2289211-2-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
In-Reply-To: <20260919213637.3316595-1-benquike@gmail.com>
References: <20260919213637.3316595-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In ca8210_get_ed(), an uninitialized u8 lenvar and a pointer to a 1-byte
stack buffer (u8 *level) are passed to hwme_get_request_sync(), which
unconditionally copies response.pdata.hwme_get_cnf.hw_attribute_length
bytes into hw_attribute_value without checking the caller's destination
buffer capacity, overflowing level on the stack when hw_attribute_length
exceeds 1:

  BUG: KASAN: stack-out-of-bounds in hwme_get_request_sync.constprop.0.isra.0+0xf3/0x170
  Write of size 16 at addr ffff888001907780 by task init/1
  Call Trace:
   <TASK>
   dump_stack_lvl+0x70/0xa0
   print_report+0x153/0x4c6
   kasan_report+0xf1/0x120
   kasan_check_range+0x125/0x200
   __asan_memcpy+0x3c/0x60
   hwme_get_request_sync.constprop.0.isra.0+0xf3/0x170
   ca8210_get_ed+0x9c/0xf0
  ...
  The buggy address belongs to stack of task init/1
   and is located at offset 48 in frame:
   ca8210_get_ed+0x0/0xf0
  This frame has 2 objects:
   [48, 49) 'level'
   [64, 65) 'lenvar'

Initialize lenvar = 1 in ca8210_get_ed() and return
IEEE802154_SYSTEM_ERROR in hwme_get_request_sync() if
response.pdata.hwme_get_cnf.hw_attribute_length exceeds
*hw_attribute_length.

Tested in QEMU with KASAN enabled by passing an oversized
hw_attribute_length response into ca8210_get_ed().

Fixes: ded845a781a5 ("ieee802154: Add CA8210 IEEE 802.15.4 device driver")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
Changes in v2:
- Split out as patch 2/3.
- Replaced the temporary stack buffer in ca8210_get_ed() with lenvar = 1
  and an upper-bound check against *hw_attribute_length in
  hwme_get_request_sync() as requested by Miquel Raynal.

 drivers/net/ieee802154/ca8210.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ieee802154/ca8210.c b/drivers/net/ieee802154/ca8210.c
index c009930..1de6314 100644
--- a/drivers/net/ieee802154/ca8210.c
+++ b/drivers/net/ieee802154/ca8210.c
@@ -1678,6 +1678,9 @@ static u8 hwme_get_request_sync(
 		return IEEE802154_SYSTEM_ERROR;
 
 	if (response.pdata.hwme_get_cnf.status == IEEE802154_SUCCESS) {
+		if (response.pdata.hwme_get_cnf.hw_attribute_length >
+		    *hw_attribute_length)
+			return IEEE802154_SYSTEM_ERROR;
 		*hw_attribute_length =
 			response.pdata.hwme_get_cnf.hw_attribute_length;
 		memcpy(
@@ -2028,7 +2031,7 @@ static int ca8210_xmit_async(struct ieee802154_hw *hw, struct sk_buff *skb)
  */
 static int ca8210_get_ed(struct ieee802154_hw *hw, u8 *level)
 {
-	u8 lenvar;
+	u8 lenvar = 1;
 	struct ca8210_priv *priv = hw->priv;
 
 	return link_to_linux_err(
-- 
2.47.3
