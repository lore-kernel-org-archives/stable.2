Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795604635;
	b=EbcIpP8u0GfjW++bn1PgZRWH8ZwyT28SfoC83tOYltRWQ67yEgxH6DbiTw3StLeaHSDx
	 mCgbdq2kDNy16rQ8uoKp6p/j2KW+Cp4qcJwJ4z0XTngRoZqKi5/6L1c4iYyJDoiFHUBhr
	 6NxNjdRYwkbYRPi71T88V79fcN529gvWsit+wAmuYh+xL2UjF3l+waCegUg2n06zcWedL
	 JirCCv2UOjk87Dwu/8V1gl2kXPS+7L2xKhZUNFsF3AsG3KxARrN24wa9FXVSUVDzyUjQH
	 RBxPh/PN2Ru4ZY21GHKV6PJWHj0C3GNyOb8hMc2X7ARrMCkihkcDAe8/YbiQY9Xujug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795604635;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0kNQWd4xFKVKn6MSVwE1lsRc4X4V5piL50Xtk3okz4Q=;
	b=HsQ8Wuhk+QdMtGGzSo4yqUZWP09z2NXP+dUNYPgjFtI7qeBriA089/PcuesZS8Sd+pZ1
	 Qoh0AZ2ZTgen1Zag7HiDO9hymFaH7eFuE7+lfIqJ4x99o82EGL6kri0TrRiVPsE3avHq+
	 Q/lE1gj62miymOzo1ojZ+ZT2iRHoY376pqkriS/i+MyIPFfI1yHqy4/Knlw2tAtvtOS0N
	 uFUnFLSvGFj//rZnBU/u+n6oKXL9Mc0eAVT9nG0T/VMvlx8pNZPVjTCtdhUoYebr4P4ry
	 MePOnToctQxOEHh8eyefuiXi6zZQWKRbZNsmNgicdmFvVUa45U+10G9Vw9nQznF/hpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tEJETcDI;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C65606A33D
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 11:03:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93C65606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tEJETcDI
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-38431138772so7248384eec.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 03:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795604634; x=1796209434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0kNQWd4xFKVKn6MSVwE1lsRc4X4V5piL50Xtk3okz4Q=;
        b=tEJETcDI9nkCss/hKuXkAaC9GvIz08tJYkSrVU4Oe69bDT0B66YUaL+J69XjRnBVMD
         Ahp9NLL1bEKf6C9NL6GGrrzrPU2zSHu3En0rsnhcf2usHpCDfyQWDyHFUGUQlLEetzte
         /fgEt8ue46CS7/fi9c0QHCJ1zMmjpviN/o83uV9sIDP38eWQ+NO+kU0id6Gt41JKOQUs
         1KurRA9D8cpc2/QU2eRf5F66A6AJ7/9niMKrjpiIg8pxK28Mg+Vbkx9/7HjPtkDqX+xO
         C7i8OI7DcesHsNNnD+jgPDxNijanItWp8h0zKHYWDgHGLxptDPhsIfMFCd+PZCDXAwUR
         ZnOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795604634; x=1796209434;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0kNQWd4xFKVKn6MSVwE1lsRc4X4V5piL50Xtk3okz4Q=;
        b=TvBQaDAK6kpel0MAHH44gwGAS6xC9e9MJUHSl/HcQjHADcHDthb0pyVhXX2/YClWIm
         cAeS/23uptYfuASbfWOYWmUYqBvO0/Xz5a+dkafYM2fPT+ilg8IPBwL5oD8B41gZKyXQ
         W7tGJpjxsQ2akRQuoSn2JsU2+O5DmeNC1oYifjJmcXO+2F9YZ0WmlYvdN6X4MYqNaqNC
         gnpDJXSHWzN6VwZedFFL6f14oeqoFF1VTF7XPPQaFbQTR9E8GAABroFiW/v93De5ouyg
         50pHA3uxoRNvnfe4yITk/bXobA+DTHxocx1sbwkvuG2pQ5WiiajUGwhCSJlvPqCc8dJx
         eiog==
X-Forwarded-Encrypted: i=1; AL+hErHBlHOZOvryRg3ogrLDaCEV+ACJqdajG6J+QI6Oubpup+2saPtM4V41gBWHby+PidSZNm75FYs=@vger.kernel.org
X-Gm-Message-State: APuU4Z9L66o3mDVl+eNJriBwHGwt67cmXp4950TjsEVW5ya2Bb+sWkSi
	+2/ONP1oV4LKRIPg/i7BytZeSfQ3O56Jch8nH4cphNxVPh2DkobBZLR1
X-Gm-Gg: AZFdTZcI+dqaoIaydSlj2R3o1V5RHqgLF7vB0YmRLthg+gv3gkaGHNrPZt11UCsriUw
	25gVTCbpTgtLZhNpbgFQaoy8Tgpk40jwjwHKQb1FAaT+W2dBZwBjq80enLoyK4sn86+JjLMCJAR
	wxARFBcTHhCWAXu38zUgfCCyThv9cHk82emfmFCD5XL9/Vhy63fbQJRToVF2KApRiqYUoR87ZCS
	bchu6UZ0GiM6jYEuKToI4K+xMzwYGAE/0kurQcgf7qWi4/c3Ecf5HHJ982wsI1pfwspmFeIn5dz
	V2uAY61iWaCCzOIqiBTdAfmoZPRhVnzU7YJNyYNdJPclv6sh55nB8CueqUeJ9VYNKL+mOhnvh+W
	XM/wnsXLpp1fLbOb5CiHFCDKrtwoxcBg0PUAHIua8iESPC82p5/mQ99sSfu6op01w3ALwAnzQaW
	5H7x95rU/dJciZwVoAJrkzl4c9UaiMLZiBiOr4C8qbIRAVHSJFI7AFQvNs242j79d1jffcBfDU+
	Y69rH9aKWsqoUr4jF6Q4umu9nOhkGdXNOn7S9nHSQo/IKIhDelNgO1t1/iwt+b1aae44ZoVw4eP
	7+1RFzVCO4XfT6XToiQBGPM4xU94SZdZ6YD/fxUcpX5jJuOr2VUpVezcInl+PMj7kBLVjaJx6A=
	=
X-Received: by 2002:a05:7300:ce8f:b0:375:7be3:1bbd with SMTP id 5a478bee46e88-38570b336f4mr16085568eec.23.1795604633460;
        Wed, 25 Nov 2026 03:03:53 -0800 (PST)
Received: from BenDellReactive ([117.20.154.221])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385f68bc0adsm49317327eec.13.2026.11.25.03.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 03:03:52 -0800 (PST)
From: Benjamin Dornel <benjamindornel@gmail.com>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Benjamin Dornel <benjamindornel@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH wireless] wifi: iwlwifi: mld: fix net-detect wakeup report after kzalloc_flex()
Date: Wed, 25 Nov 2026 19:03:47 +0800
Message-ID: <20261125110347.884775-1-benjamindornel@gmail.com>
X-Mailer: git-send-email 2.56.1
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

Since commit 69050f8d6d07 ("treewide: Replace kmalloc with kmalloc_obj
for non-scalar types"), the net-detect wakeup info and its matches are
allocated with kzalloc_flex(). Both flexible arrays are annotated with
__counted_by(), so on compilers that support __builtin_counted_by_ref()
(clang >= 19, gcc >= 15) kzalloc_flex() also sets the counters,
n_matches and n_channels, to the allocated sizes.

iwl_mld_set_netdetect_info() still uses those counters as the next free
index, so every match and channel is written past the end of its
allocation, matches[0..n-1] are left NULL, and the counters end up
doubled. cfg80211_net_detect_results() then dereferences matches[0] on
every net-detect wakeup that reports a match:

  Oops: general protection fault, kernel NULL pointer dereference 0x20
  RIP: 0010:cfg80211_report_wowlan_wakeup+0x46a/0x680 [cfg80211]
  Call Trace:
   iwl_mld_wowlan_resume+0x9d9/0xe40 [iwlmld]
   iwl_mld_resume+0x1d/0x50 [iwlmld]
  Workqueue: async async_run_entry_fn

(0x20 is the offset of ssid.ssid_len in struct cfg80211_wowlan_nd_match.)
Without panic_on_oops the machine is left wedged mid-resume.

Fill both arrays using local indices and store the number of entries
actually filled in, as iwlmvm already does. Also stop setting a match's
channels when they can't be reported, rather than leaving n_channels at
the allocated size, and report the matches found so far if an
allocation fails instead of returning with n_matches unset.

Seen on an Intel BE200 (iwlmld) in a Dell Pro 14 Plus with kernel 7.3.5
built with clang 23, with net-detect armed via
"iw phy phy0 wowlan enable net-detect interval 10000 matches ssid <ssid>"
and that SSID in range during s2idle (also with pm_test=devices). With
this change the same setup reports the match and resumes normally.

Fixes: 69050f8d6d07 ("treewide: Replace kmalloc with kmalloc_obj for non-scalar types")
Cc: stable@vger.kernel.org
Signed-off-by: Benjamin Dornel <benjamindornel@gmail.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/d3.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/d3.c b/drivers/net/wireless/intel/iwlwifi/mld/d3.c
index 77e4850..e67a22a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/d3.c
@@ -1423,11 +1423,11 @@ iwl_mld_set_netdetect_info(struct iwl_mld *mld,
 			   struct iwl_mld_netdetect_res *netdetect_res,
 			   unsigned long matched_profiles)
 {
-	int i;
+	int i, n_matches = 0;
 
 	for_each_set_bit(i, &matched_profiles, netdetect_cfg->n_match_sets) {
 		struct cfg80211_wowlan_nd_match *match;
-		int idx, j, n_channels = 0;
+		int idx, j, n_channels = 0, n_set = 0;
 		struct iwl_scan_offload_profile_match *matches =
 			(void *)netdetect_res->matches;
 
@@ -1436,10 +1436,9 @@ iwl_mld_set_netdetect_info(struct iwl_mld *mld,
 				hweight8(matches[i].matching_channels[k]);
 		match = kzalloc_flex(*match, channels, n_channels);
 		if (!match)
-			return;
+			break;
 
-		netdetect_info->matches[netdetect_info->n_matches] = match;
-		netdetect_info->n_matches++;
+		netdetect_info->matches[n_matches++] = match;
 
 		/* We inverted the order of the SSIDs in the scan
 		 * request, so invert the index here.
@@ -1451,17 +1450,21 @@ iwl_mld_set_netdetect_info(struct iwl_mld *mld,
 		       netdetect_cfg->match_sets[idx].ssid.ssid,
 		       match->ssid.ssid_len);
 
-		if (netdetect_cfg->n_channels < n_channels)
+		if (netdetect_cfg->n_channels < n_channels) {
+			match->n_channels = 0;
 			continue;
+		}
 
 		for_each_set_bit(j,
 				 (unsigned long *)&matches[i].matching_channels[0],
 				 sizeof(matches[i].matching_channels)) {
-			match->channels[match->n_channels] =
+			match->channels[n_set++] =
 				netdetect_cfg->channels[j]->center_freq;
-			match->n_channels++;
 		}
+		match->n_channels = n_set;
 	}
+
+	netdetect_info->n_matches = n_matches;
 }
 
 static void
-- 
2.56.1

