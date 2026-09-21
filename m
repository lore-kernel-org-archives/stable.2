Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0276843C7C5
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 07:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789976528; cv=none; b=ajetuOdrLm7A0NDTCKlYZJ7MGM42ASlvGjtN+fLvLKwWLCWXvWEopWOwVmyFjxB/jATlzdGTnYMku8IgWT8S3+WtFnGbKOVeSgOOFD8tGowxggDHge0AzcwBE0WYhKVPTLNfKnLtDGmEkSgol50Zqxqs2tmllaC6Rix2MkQ598c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789976528; c=relaxed/simple;
	bh=YpyUyxCo507Mg3FfSIChnx0hchuXkpf1IYcucI+jCnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SqPP5g0eRBJdKAsfIDchWSzZpBFoO9y0FW35lwbTYJB8JfuxGz7jVP57yHlBU7Q8m2UjZsOEToDVWxSo6V15yMyA876pi8NTlaBbgu0oH+Rd+9A1ALSHHx5eUOhDTMAEF2091wBAS3P15alAwF5jEqqcK9M7/Lvld024X5ApG/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qqe+lclB; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qqe+lclB"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-398c066106cso2056654a91.1
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 00:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789976526; x=1790581326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r+ECARSANJrUe2ZD7obBA7E5y8RycSAtQslnQO+mgvc=;
        b=qqe+lclBJb1rqSKhljacPsLAQQB9CrIzTdz9rVjqy3nmHMYP1cVYKqlL/o6DscJBdS
         YcH5uPgiEYyg8ygMLcF9FkqMycohG7XNkqyzE1ps1scI+jSe/M6KMdSMaqig1iQYE/2T
         NDXqct80WAVrgXtYG46f+0F5dXfJlL4EItKAm2vZ0+AcMBYaX7Ft6f/Vs1h0ZP83Ly1J
         wKLvduSXgZpDrWi5hbHLnhSgdb9jAydl/x8vYfpDZax70yrkwn8YrUgamZzRSMV0WTlf
         onlkr34+utbZIPGAcVczJ8aeKyzzlKsLfdP8inAVt9hcNwYnVZZLURW1pihW9H4ahVwy
         yYmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789976526; x=1790581326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=r+ECARSANJrUe2ZD7obBA7E5y8RycSAtQslnQO+mgvc=;
        b=Bnln8J5xUhVJjFRwJrFSY7+XhfTEhtQBCLPyBpOJsPinAcwGydpbIBRJLHU+qdU0ek
         fvb7s6cnpj7eRm0xXEEGRzaxpj6SRI8aKMVVkbIY+ochsOaov0OvNa6nTo9kChsxZxSj
         puDRCcpChmtczgXkHdtx1eL6WbX+eKpiEpH4F1Ov7vYkcwCXoIi6K1EZxRyUS15/wx4K
         Te7HTooR4hbzF4sYAupTFiWMJ7SpMKmFl20ERQIfxMaZIn+PRXvJt6Y7Fupl7eqz0wKM
         t4aWvYxKFqqf2DEOtx9rR3HtxBVdTjXe3KyJz2MaFGV1CN6zalhlgBRJrMV2PIW3rf7Y
         mizg==
X-Forwarded-Encrypted: i=1; AKwUvBzSHzXpG7u6fHmRRyNQKacx6IaG0ORNCdHN0ulPWD0l2OJKuvDYKiaolkFT3dt81CxCvYdFm3o=@vger.kernel.org
X-Gm-Message-State: AFuF++kgz6prZAjdxGZGS08sRfiF+Q29XBz0PHgOTqF9utK77tBkAD+m
	Dvk0POj+zmu/8MyLIa3KZ/IWjyW2wMHHwauRsQWX5obeC0QW/i+aJRv0
X-Gm-Gg: AYBFou3v2AVnBDH0L8A5f13MyEL3aCBpVdUnSzA6fp+jup/k7BDFz6UgMl3lxFFr6OY
	hJ8/iKvEJl1W3QT8yjV+PXloIBPmjqqfi5m9i7saivLz+cw2kuUY4RdJTjSb4uJaBidURSy/Ymp
	hUwxL+bb1Z+rGLPXiliX2AU/MSsTgikHEgxnrC6RtYQ13FwVS5uNh/Zo+JgYx9oBdUQq/SpEA2G
	LuP19dT7LCjVnWXbvbxGn6bZ68/7pzUeZ1dhBf5hQxNxoUCBYEgRdc7ZTlDiSDpJLJwM8vIiw32
	f4cORc+FjSOblPebXyWbrveeLBo/jPXl28Df69EHHBPDDPrpV2pk2Xn/7DVRhIZE+mElq/pnMOT
	9iBYMPq8X0FSaeoBMXeV4tiqnoOAt/wkcQY/Yuw4G14oEgVjh37cV8O5VKwNXeEZrvVUFXwrWfv
	BXfMMExpi3zG6U95inFz+nHxjn7h+LnsnWgPR1IOwVWgBIe5N8FMj8vJo+8RUbhGmOu63rZoJR4
	hoyXP05JcBRkKv8dEEY6xTYWwBHYsvtIuqLMt2oXPWtiumdeoKh0Px9HaM75eX2OqPcwmCNzAks
	oUhOotXGwA==
X-Received: by 2002:a17:90a:6c82:b0:39e:6a81:c923 with SMTP id 98e67ed59e1d1-39e6a81c9admr6628207a91.22.1789976526137;
        Mon, 21 Sep 2026 00:42:06 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6cabb771sm13015876a91.9.2026.09.21.00.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 00:42:05 -0700 (PDT)
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
Subject: [PATCH net v2 1/3] ieee802154: ca8210: prevent stack buffer overflow in ca8210_rx_done()
Date: Mon, 21 Sep 2026 07:42:03 +0000
Message-ID: <20260921074205.2289211-1-benquike@gmail.com>
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

In ca8210_rx_done(), the packet length len = buf[1] + 2 is only checked
against CA8210_SPI_BUF_SIZE (256). When buf[0] & SPI_SYN is set and
priv->sync_command_response is non-NULL, memcpy() copies up to 256 bytes
into priv->sync_command_response, which points to a struct mac_message
object (sizeof(struct mac_message) = 250 bytes) on the synchronous
caller's stack, overflowing the stack buffer by up to 6 bytes:

  BUG: KASAN: stack-out-of-bounds in ca8210_rx_done+0xc4/0xe0
  Write of size 256 at addr ffff888001907660 by task init/1
  Call Trace:
   <TASK>
   dump_stack_lvl+0x70/0xa0
   print_report+0x153/0x4c6
   kasan_report+0xf1/0x120
   kasan_check_range+0x125/0x200
   __asan_memcpy+0x3c/0x60
   ca8210_rx_done+0xc4/0xe0
   ca8210_spi_exchange+0x12e/0x190
  ...
  The buggy address belongs to stack of task init/1
   and is located at offset 32 in frame:
   ca8210_spi_exchange+0x0/0x190
  This frame has 1 object:
   [32, 282) 'response'

Bound the synchronous response memcpy() length to
min_t(size_t, len, sizeof(struct mac_message)).

Tested in QEMU with KASAN enabled by passing a 256-byte SPI_SYN response
into ca8210_rx_done().

Fixes: ded845a781a5 ("ieee802154: Add CA8210 IEEE 802.15.4 device driver")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
Changes in v2:
- Split the ca8210 fixes into three single-issue patches (1/3..3/3).

 drivers/net/ieee802154/ca8210.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ieee802154/ca8210.c b/drivers/net/ieee802154/ca8210.c
index 01af4f9..c009930 100644
--- a/drivers/net/ieee802154/ca8210.c
+++ b/drivers/net/ieee802154/ca8210.c
@@ -697,7 +697,8 @@ static void ca8210_rx_done(struct cas_control *cas_ctl)
 
 	if (buf[0] & SPI_SYN) {
 		if (priv->sync_command_response) {
-			memcpy(priv->sync_command_response, buf, len);
+			memcpy(priv->sync_command_response, buf,
+			       min_t(size_t, len, sizeof(struct mac_message)));
 			complete(&priv->sync_exchange_complete);
 		} else {
 			if (cascoda_api_upstream)
-- 
2.47.3
