Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793267283;
	b=RiL3rFO3onLYKkosmVrvNtvnKZ+NXzIS42PFzmwC5u6aj+Mr604XqvKBtHNPItfcTHSL
	 syr8jm+Jc2HuPZpGOPo4c6IRRof8loslQps1pDaqGPUVV+p8uTWi7xJOr1p2M1dWD/QTR
	 qUDCfxqxiTZCfhOZQL3p8fZhsB39rpO5k03fQXVOOHcPcYdqSupf2/ZLFdrK7MurVm1/O
	 ac99Rfmz0nudbFUE6spZm4hoeZLjtg3tSUUk3q/LnwlEW9eTuhRMkGwN+i6fLE56yM4Tv
	 4va6hfbacchPyoob6e7Kk5JVrwpCmqRTjOq1f47jD0C2E5O9Cg47P4PlKHaBNVwWE8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793267283;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=aA4dQ1HDNVp6PloZLXeJ1kd3NLKw0188KeBSwOCLWMY=;
	b=K6mPZMsRQzTjQ1mGfMAojhp9Qv0XpnlruEG9dR03v6YlsgRB8CuQz6ed5yxElWvKdh7V
	 GIdE7Nklw+adnH4kRtHO6oOEpn3Kg12nGkXbrTLOl1xcK6ll/lAy9NcI4saSd6krx37mM
	 p5/AXdZDsT3vLGzAWpDoiM2MIucYEALPIOcq6Wh8NQIsUZgZcJQhmEgD8Np6fqjMBSwsA
	 utMht8BYjLeJ9AGytVAJhWb3XHpNfFMhZM2XU+QMi/ZwMdon1CKqEBCm0DBDoU+z/NzIi
	 bZN/9Re8nCPLqxYRXDM11pqTtRetWR69wXKQI9043gv6aNE5BxdtpEB8Na4q1HmmIJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AVw43DXB;
	arc=none smtp.remote-ip=209.85.210.182
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6AE606A329
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 09:48:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A6AE606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AVw43DXB
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-88cfa501c5cso1017485b3a.3
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 02:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793267283; x=1793872083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aA4dQ1HDNVp6PloZLXeJ1kd3NLKw0188KeBSwOCLWMY=;
        b=AVw43DXBiUII8K4oi4Y9CYkVK44ibUTbT/35PQgwdH65QJHiKCdQnkdxjFOqDKpppt
         cXK9SDiuD1mh7L/uyLS8yunJYr/FFn5c//YgdwMFHjfS12T/bWYdHDqj+XXHNo8i57L3
         4IO6z14DdxtLa6OJnl8l9IunM3Q33qRmOPPPgy8IWF6RXN1wscg6XNPlGzG2iqf5WBYO
         EEc1TpAPwDt8IDhhPziHZgZBSWTdxK6ZMMtv9FvTnHschxj0ZVHaUi0Y8t1uJJQJq40C
         H5XuCNNnaHRiP6ltJDemWOJ6pNw/JLVsrXLqraekWZfYD45xmdBiGYvuFh8IciISJwdr
         aJeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793267283; x=1793872083;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aA4dQ1HDNVp6PloZLXeJ1kd3NLKw0188KeBSwOCLWMY=;
        b=RhAD25MRYCy3Lf49iZvcx/FnFW5rbi5ndet8gixdb/+OxxDKPpAUUXIK4VijZBF0pG
         RL4N7xW4d59aRJ/BKtT1Mj8ebZ9d+v1haeTmk4kcKV6ZoOVkwLlmEmoQrSlmezy8d7+o
         35K+/QWbPtw3TV6AGKR9IPt+YgmnsAYLisjAS8kKj/8Sg4fzFR+6Qpk/kyO/Avfz/7xS
         30ACYELx22dXgwgW3usRjG7zU7PERYy9wj33cnr14aKHqlTkqnDXVjkbm7qN2qWLBdq1
         BoiHGt5kEHkcr7qHUPkqate0BMvmYWHKq3rEZNKgFQzElElMQywOEsQgwqYwYxtcFo2c
         ZHpg==
X-Forwarded-Encrypted: i=1; AKwUvBw5CIBKPZsUjVIRfRebO5o+2xIpjbVWDg7KL4MaEFsgETSdAzz/VeZ7IyJ6zI6Ty+sPgtJogYw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLhXL9z5KjRrHwBrjFRa3IRRbCYvSPqTxNs2ve0hNjr47qf8Dhb
	rzDY+0nakoVcUb7e9ehHNejNrepBqSD7KQH3Z8kE392eR1i/qdsSvkt0
X-Gm-Gg: AYBFou2hntyn9DkNN47ZTpUHFo73bO3ChwhsmzK5VEIEJh4I70P3ZfSLfm6+6lrn4+I
	MCDK8zWP/Kae7GzBFkgjeyvSnVJhkHmP6Js7MUIyAYRbNpqojmAhpQryPQWvQLVQ5AncvFRqTpz
	QSHtffmOuVmyBwV/666vdyM7Zwma7SjJurDdTSBVtv59tp1yLxnwDDA7BCbmg2zkMDL/9pJ8IPQ
	rn2BmR4QeHU55iwQYwpXU8bSwnccHu8wc/wTBwrxtziB2B4oOHHAuIN+PE6aNKIXiaCJW55V2bn
	2nNdLoaws5MzzVPOOi07I3CwOPFhGzjG2lheOQ9/stt8X83gQ3XOuE4ptjZztY63cxsmbFJng6O
	bnrTpLpEB12o4Gjw8sgz2k9+baF3dZVSFE7ViGih1Wy9RbFar2lN0BZ4VPAbliaMabSKhpwWCKT
	D8wdcJvXu4xOjsSTxp/A3cV3YiGxbHgOPGQGWMG1uZw4yKqs/WtnUrkQ3V+N3QvkGsZb4av1EzD
	7nlTm0otHQwfOmVuCaQg+anW+vOVv3wUjr3bKCuGGAmIHnuxK0q/bRsrlAxjJQHJUADFWrwgKVE
	WnszrgMwnJaxDnjyb5bwJUm+sF4ON2YW5dQAhGO/fc+cYqHSfnUGaEOBDcqQ1sJf0SxRs27YqP+
	8cIQGuk3qiw==
X-Received: by 2002:a05:6a00:854:b0:89e:ba55:119a with SMTP id d2e1a72fcca58-8a6e83aa99amr3590208b3a.47.1793267282263;
        Thu, 29 Oct 2026 02:48:02 -0700 (PDT)
Received: from KRHW1CJW23.bytedance.net ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a6a662b9f5sm2187143b3a.21.2026.10.29.02.47.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 29 Oct 2026 02:48:01 -0700 (PDT)
From: Zhao Li <enderaoelyther@gmail.com>
To: Stanislaw Gruszka <stf_xl@wp.pl>
Cc: Wey-Yi Guy <wey-yi.w.guy@intel.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH wireless v2] wifi: iwlegacy: unregister the LED if 3945 hardware registration fails
Date: Thu, 29 Oct 2026 17:47:42 +0800
Message-ID: <20261029094741.21162-2-enderaoelyther@gmail.com>
X-Mailer: git-send-email 2.56.0
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

If ieee80211_register_hw() fails during 3945 probe, the LED class device
stays registered after probe frees the il_priv that embeds it. The next
LED trigger registration, or a write to the LED's sysfs brightness file,
then uses freed memory.

il3945_setup_mac() registers the LED before the mac80211 hardware, and
il3945_pci_probe() unwinds a registration failure without calling
il_leds_exit(). 4965 already performs this cleanup: when
il4965_mac_setup_register() fails, il4965_ucode_callback() calls
device_release_driver(), and il4965_pci_remove() then calls
il_leds_exit().

Unregister the 3945 LED before unwinding a failed hardware registration.

LLM assistance was used to find the bug and review.

Fixes: 5ed540aecc2a ("iwlwifi: use mac80211 throughput trigger")
Cc: stable@vger.kernel.org
Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
---
Changes in v2:
- Explain how 4965 already performs this cleanup (Stanislaw)
- Describe the use-after-free concretely
- No code change

v1: https://lore.kernel.org/r/20261028142328.18560-1-enderaoelyther@gmail.com

Validation: A W=1 module build with MODPOST passed. Not
reproduced; 3945 hardware was unavailable.
Sparse C=2 passed. Targeted Smatch introduced no new diagnostics.

 drivers/net/wireless/intel/iwlegacy/3945-mac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/intel/iwlegacy/3945-mac.c b/drivers/net/wireless/intel/iwlegacy/3945-mac.c
index f7ca182d1494..5e11f0597255 100644
--- a/drivers/net/wireless/intel/iwlegacy/3945-mac.c
+++ b/drivers/net/wireless/intel/iwlegacy/3945-mac.c
@@ -3529,6 +3529,7 @@ il3945_setup_mac(struct il_priv *il)
 	ret = ieee80211_register_hw(il->hw);
 	if (ret) {
 		IL_ERR("Failed to register hw (error %d)\n", ret);
+		il_leds_exit(il);
 		return ret;
 	}
 	il->mac80211_registered = 1;

base-commit: 25e73f1d6868c759c8eb56cad4e411692c5341b4
-- 
2.56.0

