Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C951840DB2F
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 08:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789027426; cv=none; b=U74DQ1d2v6gza1rmMXr94qi0zI/YoNaEjYeMPZ1u3VL2stN7RzQ0ZQ3AapC/y3CDz+QQfaKrecdU/YDF18jbdrXeONrNG1kD9mOv7X9/4OebFlhIjZzDc7VkFj64WWgcRNThSdUjp2+lgySln3hOjl8TnH+qHUJoTpe5uDKCrIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789027426; c=relaxed/simple;
	bh=It3hGucDlDiimzY7cb7O9jAeM6W782d0j84+5HqyF5I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QY3eg5j+s72JFkb8qPJviT1RObruAQrHDtoDWrKCmpcvxrrNIXfOz19HEjDFPcamENSdONGv4rY46xiHYED+wdgwZ4lKFyyZtcUhpp16CQFiIke7cTOTXxvLC+88krySNAU4a5mgv5kTSNdL5vfirNTzNbVg/xlX12Q+Zgqw4I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dGmvS1vx; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dGmvS1vx"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2dd020a2e44so14254665ad.1
        for <stable@vger.kernel.org>; Thu, 10 Sep 2026 01:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789027414; x=1789632214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=i8zhbFIVLiK3IaZuONcJMvzZFWnMkWhoBnRei/mXFFQ=;
        b=dGmvS1vxQmfm28mdcgr2t/zq4MoCMBORveSLgeaT1V4o+aBUi/6aEaZJ6S7AJl9EWA
         P1vwF8oiWde7dqi6RUz8SNty52wD2NDpDTeWuyb25p9ZSovJxnmcLThGjCveLz1iQETv
         iZ9UwFkAg58UV0GzyMAPhYL9my0ojnvFQbNWwFGhhRUXBl/LBtS2jB2v59niM9QDOCgF
         YPLp76W4sL5CMx5QDyhdTJ70PeztfykU8FEYG2J7nu+sI2eZ8QqdwggVB3PIxyMyHEWQ
         ZVlWkxgIWyMOUKZtY3h/GntjVb0nBdAJPr+Flwwg+DR58Iv84Otk4iK4TFSvEChrbQgm
         ab8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789027414; x=1789632214;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i8zhbFIVLiK3IaZuONcJMvzZFWnMkWhoBnRei/mXFFQ=;
        b=mrv7cIzA1TFJ9UudcJUbHdLH1cSgiMXOjO1ht2/vwMCIbr3X/KBblYaIL0a2hMuj12
         SOFNxx0OAy0dA0+lqt2Jj9QmLdqABC3mqhOoUX3UgRVW6k0U85vEDRkleJeRkkwIx8po
         vW+lHgV46a6llERGovHRQzYw4TTnsHbD4SL/5zykINILfIj55QRj9Gewo9X/6E9F323R
         VzhMoXYkeECyvpqnEARbkMEejcBbrErwU23IGsG9vT8t8orqyzJ6MpRhckR7M00UD+2P
         1eNFln3F2wcAa/a4i7sBduFFAPU+o7qZbkjnG4f4r+VEhc+MMgovvHmtUzsOWSQsgOad
         uqbw==
X-Forwarded-Encrypted: i=1; AKwUvBy8glIj8YdnS0GO4TnMHoarpgdvGxwpjOXfDiuaYZmRwLfqhau5KmKM8XLGiRi/R6GuiRblMCw=@vger.kernel.org
X-Gm-Message-State: AFuF++lQW+Pbr9W3yYZq/OENH35LA+KDOy13AHwqqzDZNqa9bkLKYHOy
	WMpXRm7LhTUcvQ5Bs//ho6b30OX2l4jrw8jVLORNr6ZpztkNxqyxHLUZ
X-Gm-Gg: AYBFou1IsJNNAdQQaJyExCLbAZ5NVEUaFtmoRpybibUO1rLKksZIzdMkMlXRc9UoyzM
	UEhrvGjqmoHJEYiM62CEHg6zd220mQ6kgeAKm2H7zPwsmRK5oDgPMShcxKVw38UjbkKbJNciY3y
	Ogq2imi2EWN7DvFWO1juC+PqTUART3h930o0sOVUGKWpWdYroE1i2OMsZh8vpORkzmhRBu4g1H7
	Y7V8bIz6AUw6IrTp6lZhT35c1MvVAbpHMpf41Qnc3UJqDNQ3+ANC1VwZ69D3nreiAnsxCcjKa2i
	A8/aWUHJukR3qXNlda4WN6halN+PScYA4K8U8aVDZAT1cRa8g0rpnqzQXXL3hN8HGp0CMgyshd3
	8BfR910jkomznerp9Ariis0vEJ2SwoexcYBTMutFnkoiTunlimhNuCjBYboO2E6yEFQ9tVHHnSt
	+rq1dc8X3SMdn3+8pa3+iJsr1UNCIs6b2U79hWJSWONiDsdOFa9hjvrDsaulWgalpR+NG2qeBqf
	wBQjZCzJ93B4AJCB6x+5bYyQWxaftZXo27gtHHWHNEpnEAl
X-Received: by 2002:a17:902:b114:b0:2d9:1dee:43e3 with SMTP id d9443c01a7336-2db12757f17mr383673035ad.18.1789027413851;
        Thu, 10 Sep 2026 01:03:33 -0700 (PDT)
Received: from localhost.localdomain ([180.101.244.71])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db2db7f088sm69745075ad.35.2026.09.10.01.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 01:03:33 -0700 (PDT)
From: Aohan Mei <ljp1205831794@gmail.com>
To: netfilter-devel@vger.kernel.org
Cc: pablo@netfilter.org,
	fw@strlen.de,
	phil@nwl.cc,
	coreteam@netfilter.org,
	Aohan Mei <henrymei@tencent.com>,
	TencentOS Corvus AI <corvus@tencent.com>,
	stable@vger.kernel.org
Subject: [PATCH nf v2] netfilter: nf_tables: skip expired catchall elements on insert and delete
Date: Thu, 10 Sep 2026 16:03:19 +0800
Message-ID: <20260910080324.2663491-1-ljp1205831794@gmail.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aohan Mei <henrymei@tencent.com>

nft_setelem_catchall_insert() looks up duplicates with
nft_set_elem_active() only, while nft_set_catchall_lookup() and the
dump path additionally skip expired elements.

Once a catchall element with a timeout expires, this predicate drift
makes it invisible to userspace dumps, yet it still blocks
re-insertion: with NLM_F_EXCL the request fails with -EEXIST, and
without it the request reports success but silently inserts nothing.
The stale entry only goes away when the (user-tunable) gc interval
elapses, so the catchall rule may silently stop matching for an
arbitrarily long time after its first expiration.

The delete path shows the same drift: nft_setelem_catchall_deactivate()
picks the first active-next entry in the catchall list, so with an
expired entry still pending GC it retires the stale entry instead of
the fresh one, and it deactivates an element that userspace no longer
sees instead of failing with -ENOENT.

Align both walks with the lookup and dump predicates: only an element
that is active and not expired counts as a duplicate or delete
candidate, using a single timestamp snapshot for the expiry checks.

Reported-by: TencentOS Corvus AI <corvus@tencent.com>
Cc: stable@vger.kernel.org
Fixes: aaa31047a6d2 ("netfilter: nftables: add catch-all set element support")
Assisted-by: CodeBuddy:Kimi-K3
Signed-off-by: Aohan Mei <henrymei@tencent.com>
---
v2: drop the is_dead check, it does not belong to this dedup walk;
    use __nft_set_elem_expired() with a single timestamp snapshot;
    also skip expired catchall elements in the delete path.
v1: https://lore.kernel.org/netfilter-devel/REPLACE-WITH-V1-MESSAGE-ID

 net/netfilter/nf_tables_api.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 765a92fa90d6..0f3449cca5d2 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -6991,11 +6991,13 @@ static int nft_setelem_catchall_insert(const struct net *net,
 {
 	struct nft_set_elem_catchall *catchall;
 	u8 genmask = nft_genmask_next(net);
+	u64 tstamp = get_jiffies_64();
 	struct nft_set_ext *ext;
 
 	list_for_each_entry(catchall, &set->catchall_list, list) {
 		ext = nft_set_elem_ext(set, catchall->elem);
-		if (nft_set_elem_active(ext, genmask)) {
+		if (nft_set_elem_active(ext, genmask) &&
+		    !__nft_set_elem_expired(ext, tstamp)) {
 			*priv = catchall->elem;
 			return -EEXIST;
 		}
@@ -7088,11 +7090,13 @@ static int nft_setelem_catchall_deactivate(const struct net *net,
 					   struct nft_set_elem *elem)
 {
 	struct nft_set_elem_catchall *catchall;
+	u64 tstamp = get_jiffies_64();
 	struct nft_set_ext *ext;
 
 	list_for_each_entry(catchall, &set->catchall_list, list) {
 		ext = nft_set_elem_ext(set, catchall->elem);
-		if (!nft_is_active_next(net, ext))
+		if (!nft_is_active_next(net, ext) ||
+		    __nft_set_elem_expired(ext, tstamp))
 			continue;
 
 		kfree(elem->priv);
-- 
2.43.7

