Received: from mail-dl2-f42.google.com (mail-dl2-f42.google.com [74.125.229.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6777D282F17
	for <stable@vger.kernel.org>; Sat,  3 Oct 2026 01:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790990682; cv=none; b=IAKv3na4PSsM2xe514IVsGugZB0RL4xIWh/pWYzlrZiZ57DUHOBo+C6LzKxAqVXlhyahRJPy30yZP3BsEZZKYgEgIY5kRtvCgpV4B4AtDs3+4/so3G3D4tRCwxMhcMNEHO0h8KCBk+BzS5rOknHN1ehGx5TYU6RMDTd7T/eF2bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790990682; c=relaxed/simple;
	bh=nSSnGU5Yx8N8KK+quTfdPW0j3gy9ZC4p0zEt/0tq2TI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QDA612B3A9L/1Wo43HxM3DHqu2O1uvtOOyoe44RxRKwo3PyvavCJ7p3WXXGj9HJakvNlH/ovTBjp49lS0EpeBIXEas/F6tIGUwtH5wPxYUONMTDhVBdviX9UHf7mctORgfKk7nPj1z1ugVb1rfmLkAI+Sn9iGBdgIbhq7rvGX/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fg+nfPUz; arc=none smtp.client-ip=74.125.229.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fg+nfPUz"
Received: by mail-dl2-f42.google.com with SMTP id a92af1059eb24-144f47a9b57so159896c88.2
        for <stable@vger.kernel.org>; Fri, 02 Oct 2026 18:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790990675; x=1791595475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7VKEIe5eDy7HrK5OjwFax3ISkV7YBLxCBg00wMz1hao=;
        b=fg+nfPUzKhORgMfjkzPbJyWR+l58RUkrkLwBKUkZl/gr9spjfnNWhzMYx3O5r/5Jbd
         8YeSx1wtZ1wV9bMFx+C3BJDrKhHpbo+mfqUfialvP/D4rFtvatXI7kDyr2o3znQIXzC0
         hOpZWQXopqDUxByiCxZNb3PpTBeHgkPIJ/RpyufpbVt77gSPhJpow+6+QtCgyY6OwS5p
         gEdnDsA4FA7/Wl6cVkTroryaSL9guePU7jRk7zQ8qPqsIQxy9yd0M+PYm+WfZPiecz4b
         Jq1b2GYSWJmCFjNnN0YBpvLuewU9qSbFAVKbLiMBtlw6Y2B+jPqrSkxSjChHkSZ0eOhg
         HPSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790990675; x=1791595475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7VKEIe5eDy7HrK5OjwFax3ISkV7YBLxCBg00wMz1hao=;
        b=NotxEaRHxEpJMreX5ftA/XAtFulynwd5mT//N0JlZu0AdweCHYWJU0I+tJz6kDPG42
         eAGZgWap+grEfRPdoCF/oe8sMen+Gn9iOVIICGHnTXbAJT+enZh4mM8F8xjvp83MpjSl
         BSL7cSxoPK14ZcGsWrHDsI6qK0Sunprot4IEOF5KI5ycJlrfuAL2Ssz0QW/hYRQ+i27C
         eyf5CPEgk6fKU0u08gLn+gK5uWfWAawcOFGjYyrSuhj3W1xOCgcQFPM167YwDbzhGfKr
         cqyDWcdyjDnL+QvjKqh+IN5KhpbkYsrUi0/riPEZV9CDHsaRqxlCHQdVVatBPx8ZFbvC
         +Gzw==
X-Forwarded-Encrypted: i=1; AKwUvBweVxet+PgMyLQvBwBoz9D3524nTkPpt3ptz+RpasLlKM2SSSVgs2uAyImiL611s0Bj3/dd+Gg=@vger.kernel.org
X-Gm-Message-State: AFuF++m4kNxrRyXOfEqWBFzJzdYllntqWFJhJUgtK/mrOpSxcODWyMH2
	tIwhhdyEwiDN/EbQnOaKS3I/koZnHvUIctWyO4o/YRk69KiPoQrNc22X
X-Gm-Gg: AYBFou0IdZpEfXgcGBebc1eaI1PLuoWjk61Hyx6mmmQ9JsIZ8yUlKAHuSoeCJIjfVeq
	LBZBG2SK6vMYuCCOExkr00k6YhsIEz22x4iIFzAKok0peShmm0YoCF2Cr6GRoJrTN226JJY3e0j
	EBNevbCbpmdX6W0dl0i0/R2xGucLwe24b/z8CIrMHL2LZadMSoQ9hu6JofmuA+Ojr3ZYHsqjQ9N
	wiw2I7XcgsiMr9UphCY0zl86JWrCzGvq7bC9yP8M1QEdFcERdDYKhniECDHwbPIvG/CS8l1ZF2R
	6pT4OlSadHYQpKY3ErIikKJ7WvA3HyudCaxeUeBoiWNoSscvVq//nRNk8am4iE2U/2BkNZjntP+
	dEtzDP4AWQypD0BzZb1HD0WZkAEA5bORuaHSvC29rI4D7sqTOgYGA58/yhh0o1zxHrYa3IWNQ24
	9ZXg5tfiWYJnaHlab+A6hVvDYjk8YW6oTvzkQm6zRlIvemQGli+xcmFsJJeAEi6nus80b+FzR1u
	9teLNVXVTpB1psMEBKpDH7TuoTrz4Uv7sZr7eCSpxjH1fUMO5eGtDAxc2iu3g==
X-Received: by 2002:a05:701b:2096:10b0:143:2719:566e with SMTP id a92af1059eb24-14f5d3b9a1fmr4763036c88.42.1790990674087;
        Fri, 02 Oct 2026 18:24:34 -0700 (PDT)
Received: from s1lverbox.orsomething.local (47-144-201-183.lsan.ca.frontiernet.net. [47.144.201.183])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-151f7bd2884sm1271438c88.0.2026.10.02.18.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 18:24:33 -0700 (PDT)
From: Jean-Paul Sergent <jpsergent@gmail.com>
To: netdev@vger.kernel.org
Cc: i.maximets@ovn.org,
	kuba@kernel.org,
	kees@kernel.org,
	stable@vger.kernel.org,
	Jean-Paul Sergent <jpsergent@gmail.com>
Subject: [PATCH net v2] net: dst_metadata: fix fortify trap + overread in skb_metadata_dst_cmp
Date: Fri,  2 Oct 2026 18:24:33 -0700
Message-ID: <20261003005449.2675.3@jpsergent.gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261003005449.2675.2@jpsergent.gmail.com>
References: <20261003005449.2675.2@jpsergent.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

memcmp: detected buffer overflow: 108 byte read of buffer size 96
 WARNING: CPU: 0 PID: 15 at lib/string_helpers.c:1036 __fortify_report+0x45/0x60
  __fortify_panic+0x9/0x10
  skb_metadata_dst_cmp+0x11b/0x120
  dev_gro_receive+0x303/0x620
  gro_receive_skb+0xc5/0x230
  gro_cell_poll+0x67/0xa0

Same disease as the tun_dst_unclone fix (4c6d43db2a4d), on the RX
sibling: kmalloc_flex() in metadata_dst_alloc() sets __counted_by for
the structure to options_len, which is then initialized to zero, so
the compiler's view of the metadata_dst tail is 96 bytes at the time
of the access. Geneve carries 108 bytes of options, and the combined
struct+options memcmp trips CONFIG_FORTIFY_SOURCE when built with
clang. Observed live on 6.18.54-talos with Cilium geneve, in
gro_cell_poll (gro_cells GRO on the geneve device) under sustained
cross-node RX; the warning is followed by a fatal Oops
(kernel BUG at lib/string_helpers.c:1043).

While here, fix a related overread: the memcmp length uses
a->u.tun_info.options_len for BOTH sides, so when b carries fewer
options than a the comparison reads past b's allocation. Pre-check
that both sides carry the same options_len and compare the options
through ip_tunnel_info_opts() so the counted_by view matches the read
length (the same two-stage shape the unclone fix uses).

Fixes: 69050f8d6d07 ("treewide: Replace kmalloc with kmalloc_obj for non-scalar types")
Cc: stable@vger.kernel.org
Reported-by: Jean-Paul Sergent <jpsergent@gmail.com>
Closes: https://lore.kernel.org/netdev/20261003005449.2675.1@jpsergent.gmail.com/
Assisted-by: LLM

v2: fix subject prefix to [PATCH net]; no code changes.

---

Reproduced without the fix: live kernel panic on 6.18.54-talos
(Cilium geneve, gro_cell_poll) under sustained cross-node RX; trace
in the report. The fix itself is NOT build-tested - no kernel build
environment on the reporter's host.
---
 include/net/dst_metadata.h | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/include/net/dst_metadata.h b/include/net/dst_metadata.h
index f45d1e3..60878ea 100644
--- a/include/net/dst_metadata.h
+++ b/include/net/dst_metadata.h
@@ -115,10 +115,30 @@ static inline int skb_metadata_dst_cmp(const struct sk_buff *skb_a,
 	case METADATA_HW_PORT_MUX:
 		return memcmp(&a->u.port_info, &b->u.port_info,
 			      sizeof(a->u.port_info));
-	case METADATA_IP_TUNNEL:
-		return memcmp(&a->u.tun_info, &b->u.tun_info,
-			      sizeof(a->u.tun_info) +
-					 a->u.tun_info.options_len);
+	case METADATA_IP_TUNNEL: {
+		int ret;
+
+		/* Options lengths must match, or the options memcmp below
+		 * would read past b's allocation when b carries fewer
+		 * options than a.
+		 */
+		if (a->u.tun_info.options_len != b->u.tun_info.options_len)
+			return 1;
+		ret = memcmp(&a->u.tun_info, &b->u.tun_info,
+			     sizeof(a->u.tun_info));
+		if (ret)
+			return ret;
+		/* Compare the options through the flex-array member so the
+		 * compiler's __counted_by(options_len) view stays consistent
+		 * with the read length (same shape as the tun_dst_unclone
+		 * fix); a single memcmp of struct+options trips
+		 * CONFIG_FORTIFY_SOURCE when options_len is still 0 from
+		 * allocation time.
+		 */
+		return memcmp(ip_tunnel_info_opts(&a->u.tun_info),
+			      ip_tunnel_info_opts(&b->u.tun_info),
+			      a->u.tun_info.options_len);
+	}
 	case METADATA_MACSEC:
 		return memcmp(&a->u.macsec_info, &b->u.macsec_info,
 			      sizeof(a->u.macsec_info));
-- 
2.55.0

