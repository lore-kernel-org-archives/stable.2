Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795694875;
	b=zJLEOeVaJnY7H8NtIrSEdEXr8HaHq1KqWtiGZPik2DruXoZKO7jWN4Fo3F7heuCB80Ie
	 j8y+GPC3CPFSoqx2JiRE3v0jDCmkBexM3gOpInO03OqZzX0DhdODjDRPTxZz3+9gGzpUj
	 o7ZDnVRRUOW2EGjTSOL59XdBXA0DDrk/L0IQkOkYKboaG2aocr7hwiXXZY1I+ak/OWN2B
	 +g/crvDv2hououboDhFAxQuWmlztjiDZ/5mXBTheoTFqJd4fjPgdu/Jwo+IbFAPmoITBa
	 WhPs6lOARUA+X7lT+5l5VvoXnfiNWhUs+2KlLqaVxD/trzcONkTnTo/OC+N+38WI2SA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795694875;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=lqFV5m5qZxryiSh706S6c3l55qITQc74+MuV+mDzbVQ=;
	b=1YjFX3V8ebkmWIntkU2+k68jT4cr82lJzd/ku4VDv4TfrnOW/T95+ospXwiCSK28U7iw
	 ttWdhQGrmS9JKoJqQdkchE/Bj5tB1dEKkqA9lhI6onTZkWv+nkHCA704G6pmiQ5JFn0Tu
	 n2mtyu4pMA/VrPmYjXqWkxjQjATAvVhymIxD8LvHJNTZ0Ibwp0jY2Kbai4SFNAjAj65BI
	 Hw6+ijLuEym4vwpQYxOl1XmK++arFKEcoR3QSt6gHtoC+kPF2oeJTEdFsjIVhxf1bhBXY
	 W5OYTsyEh/jOdiimSc5bGMlt8Tk9ApR+U8Oaffvm+UNUX7LwgRxO7v5LRnWmJRk1R2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=pbjG9PcX;
	arc=none smtp.remote-ip=209.85.218.47
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C86606A321
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 12:07:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66C86606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=pbjG9PcX
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c4322d310e7so190584166b.0
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 04:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795694874; x=1796299674; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=lqFV5m5qZxryiSh706S6c3l55qITQc74+MuV+mDzbVQ=;
        b=pbjG9PcX4Crz1VhitguX/i8q7xKueg0aBeU+1fIILn6lLzM1EQnki8DdhlVIzga+3c
         LJRD195qiKLsQcjoKN5P66ycIlaRdH0tblNVdR+B8xHtzPD2rCl+o5NjNP3bdAyvnPlz
         +r8MEhQgZY/MO+rJg620H8HlalpCHd2mCkTHbRITT4dsklyxobKa+SJsz13Fagpf9/yF
         hv6d5RxYkDMcw3bPtTyIGWl6R6FH63dAYpwtt16eM6NEyTQ6zDB7zEjYM53ZvGpmfm88
         6RxUyG2dQ38rWoBiCU7RI+vp/juazTlTMAbnyAaRbkXHdLPxs/IuOfzBYqNGIyp4hwgx
         eauA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795694874; x=1796299674;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=lqFV5m5qZxryiSh706S6c3l55qITQc74+MuV+mDzbVQ=;
        b=iDQfuDLFxHhbaqy+aOXqfTy2oduJY0c6mm2I6mX/Qqf3i+KoIfNVDA0CzkBBkxaw7E
         b4yKZyL3/k3VRLqX7PM8hnR1GohUX+a2JxTZMRG5vNfNVOKnfW9wapNQQKdgh9wt05Y+
         OWT6Mla5IICjCQA96wT9LfK503g+dqPyAwQcVv3r/a+OFEPa7JOmeubgKnz7T2CrUQFW
         2foRpB0/nheRZaoUcAOOEV0V4dRFYLn071mx/uVKf1HmNNFRkFnLD0UbJ9VOBECzpn6x
         0+emZ7BlWxspPccP9t+yktP56cS56OXAWZdMJIY4riQTlzheUzsl7DmhQ2OOAerH1HsV
         wtcg==
X-Forwarded-Encrypted: i=1; AL+hErEFa1dX/lOEinoyY3eEdXFkaaIMUV3CjJhoVAfktkusA6wsGx9xcPLtcBIEr6whgHydh4ocSFo=@vger.kernel.org
X-Gm-Message-State: APuU4Z+ZVz7Ljxu7fgiyZxMZEsTOgmGmlP32DUEN2wyRTwm1/dzYRSWl
	7DeWoQUFjWZf2KDv+M0V1VlcVyl+HouIFubmSLUKGv8zdaoPUp7Qmo4VFMQm/wK9aJ0=
X-Gm-Gg: AZFdTZdDFkE2CTLAF/TjrHvhBLuBwU/ZSPgjWiCQ5AzKZumGfo6G97QLdF6n0dz9WFw
	f/gx6zS7Yy10r/pXynWWKBoPPLu3B737Zl1uv4a5vhfaGsGS4Kp158g7me4Jfka8ASln/d5PMJa
	E1bAbg1lNFZQ1b7ahdV/8SUM2jn8NaMAO60DpYJYsyM4UV27ms3Wl0FEHu94J/rwnrZsNT88yF5
	4aTqSuFYpdFGUKcIxMRisxw7Z2b+vZLnqEPqhAycCSWCJar7Vca2Pfzzum41kNS2xfNW1MblXcs
	HP8uR+Bf2tV+ztpAMRvG2hyAm+LPWUSTW6+m3GeVAa92HisYsMeifJhWfHa+h/C6etvxubGcBkB
	KlDGM7Nmx6x08P6JhDscmZTGNJm5pnlsajeSr0THHYrEHvgFx/9y2A9NPsFejfEAX1IZ2tAHOy5
	fi/g4SGiHHGfqC+fNAdS/yrDltofQkd1dNLI4XG5wnNYvzsIWrvB+5Na7VqGQBv4mzqj/ARq6Hp
	xuo3wlJ8PBdF/c/hr67Oz0P6IKM1BLlP8KobEh2UdPqnBPeUck07mlEsBVha1b0qdbkfgTu8G1o
	2LjTNc0hSnWd38d2V+wPuSZGnKeSoCqDjoDCG05juFCFDa4UdZr1mb4hd9UV/5lxsmLwpSCDLrJ
	ytmYD8StO3qZgmCyrgA==
X-Received: by 2002:a17:906:c10f:b0:c51:b21d:72f4 with SMTP id a640c23a62f3a-c51b21d76b4mr426109566b.36.1795694873703;
        Thu, 26 Nov 2026 04:07:53 -0800 (PST)
Received: from puffmais2.c.googlers.com (226.124.90.34.bc.googleusercontent.com. [34.90.124.226])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513aec5115sm740527966b.51.2026.11.26.04.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 04:07:53 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Thu, 26 Nov 2026 12:07:52 +0000
Subject: [PATCH] power: supply: core: fix use-after-free of supplier names
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
Content-Transfer-Encoding: 8bit
Message-Id: <20261126-psy-core-supplier-fixes-v1-1-33de6aa53cd8@linaro.org>
X-B4-Tracking: v=1; b=H4sIABchCGsC/x3L0QpAQBBA0V/RPJvanWLxK/IgBlNim4lI/t3m8
 XS7DxirsEGTPaB8ism+Jfg8g2Hpt5lRxmQgR6X3VGC0G4ddGe2IcRVWnORiQ0+uoOBCVQeCdEf
 lP6S57d73A3LceTFpAAAA
X-Change-ID: 20261125-psy-core-supplier-fixes-120527078972
To: Sebastian Reichel <sre@kernel.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, Juan Yescas <jyescas@google.com>, 
 kernel-team@android.com, linux-pm@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, stable@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.3

A consumer's psy->supplied_from[] array keeps pointing at the supplier's
desc->name after the supplier is unregistered. That pointer dangles once
the name is freed or when the name lives in the supplier's module
.rodata and the module is unloaded.

Every subsequent power_supply_changed() passes that freed pointer to
strcmp() in __power_supply_is_supplied_by(), triggering a
use-after-free. If the freed memory is poisoned or reused, consumers
also fail to match the supplier when it is bound again:

    BUG: KASAN: slab-use-after-free in strcmp+0x40/0x80
    Read of size 1 at addr ffff0008039e8840 by task kworker/4:2/173
    Workqueue: events power_supply_changed_work
    Call trace:
     kasan_report+0xb0/0x108
     __asan_load1+0x98/0xa0
     strcmp+0x40/0x80
     __power_supply_is_supplied_by+0x98/0x160
     __power_supply_changed_work+0x2c/0x68
     psy_for_each_psy_cb+0x44/0x60
     class_for_each_device+0x178/0x1c0
     power_supply_changed_work+0x100/0x238
     process_one_work+0x4a0/0x960

    Allocated by task 60:
     devm_kmalloc+0x6c/0x180
     tcpm_register_port+0x840/0xd30 [tcpm]
     tcpci_register_port+0x2a8/0x400 [tcpci]
     max_tcpci_probe+0x224/0x430 [tcpci_maxim]
     i2c_device_probe+0x254/0x4c0

    Freed by task 238:
     kfree+0x228/0x5f0
     dr_node_free+0x18/0x38
     release_nodes+0xb4/0xe8
     devres_release_group+0x1ec/0x248
     i2c_device_remove+0x70/0x138
     device_remove+0x74/0xc0
     device_release_driver_internal+0x2b0/0x330
     driver_detach+0x78/0x100
     bus_remove_driver+0xa4/0x160
     driver_unregister+0x4c/0x88
     i2c_del_driver+0x5c/0xb0
     max_tcpci_i2c_driver_exit+0x18/0x5a8 [tcpci_maxim]

__power_supply_populate_supplied_from() stores epsy->desc->name directly
in psy->supplied_from[] without duplicating the string, so the consumer
borrows memory tied to the supplier's device or module lifetime.

Make psy->supplied_from const char ** (removing the now-redundant cast
in power_supply_check_supplies_by_name()), duplicate the supplier name
with devm_kstrdup_const() on the consumer device, and return -ENOMEM
(releasing the fwnode reference) on allocation failure.

Fixes: f6e0b081fb30 ("power_supply: Populate supplied_from hierarchy from the device tree")
Cc: stable@vger.kernel.org # 6.18+
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
Tested on Pixel 6 (Oriole) with CONFIG_KASAN_GENERIC=y:

    rmmod tcpci_maxim && modprobe tcpci_maxim

Without this patch, the first reload triggers the KASAN
slab-use-after-free in strcmp() above. With this patch, repeated
unload/reload cycles don't trigger it anymore.
---
 drivers/power/supply/power_supply_core.c | 12 +++++++++---
 include/linux/power_supply.h             |  2 +-
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 1cc203f2780b..4dfcdb720a31 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -208,8 +208,7 @@ static int power_supply_check_supplies_by_name(struct power_supply *psy)
 		return -ENOMEM;
 
 	ret = device_property_read_string_array(parent, "supplied-from",
-						(const char **)psy->supplied_from,
-						nval);
+						psy->supplied_from, nval);
 	if (ret < 0)
 		return ret;
 
@@ -223,6 +222,7 @@ static int __power_supply_populate_supplied_from(struct power_supply *epsy,
 {
 	struct power_supply *psy = data;
 	struct fwnode_handle *np;
+	const char *name;
 	int i = 0;
 
 	do {
@@ -231,9 +231,15 @@ static int __power_supply_populate_supplied_from(struct power_supply *epsy,
 			break;
 
 		if (np == epsy->dev.fwnode) {
+			name = devm_kstrdup_const(&psy->dev, epsy->desc->name,
+						  GFP_KERNEL);
+			if (!name) {
+				fwnode_handle_put(np);
+				return -ENOMEM;
+			}
 			dev_dbg(&psy->dev, "%s: Found supply : %s\n",
 				psy->desc->name, epsy->desc->name);
-			psy->supplied_from[i-1] = (char *)epsy->desc->name;
+			psy->supplied_from[i - 1] = name;
 			psy->num_supplies++;
 			fwnode_handle_put(np);
 			break;
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 7fbc0b80bcbb..7d8044d91be6 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -355,7 +355,7 @@ struct power_supply {
 	char **supplied_to;
 	size_t num_supplicants;
 
-	char **supplied_from;
+	const char **supplied_from;
 	size_t num_supplies;
 
 	/* Driver private data */

---
base-commit: 3191063649dbf7c0d0b768e1f3655e4c5fc6edb5
change-id: 20261125-psy-core-supplier-fixes-120527078972

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>

