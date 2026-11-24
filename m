Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795519596;
	b=FXGUCP2N3HkJisnnFGB/HtM4+ML60GAU2eUkX5htnrugWaYJ0B9azD2w+KJole21nUr0
	 okHXzcDFhtK9up46awQxUlOCIVML3KXj6APeutdPh+TDrZDgYHzTkBgTJ3/KKTuDXASBa
	 vzN27kVh9qKDyGZQzb85hKex+91FVrxCOjusTj00mHEkAblK+TNCyQTIz1eF6YHIU6jlS
	 O5iL8fH1D2TKkkXk3Kquw9J3QfSCzfWy8a+hZjnAsjmgDYCus/ariD1CT+T2MacxZ30j1
	 ihKevwXz9fWN0NW0bpdgIotkmzPacOzGtdd8mSGoxj+mnFFgG7M335pgq1Nm5XvzOLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795519596;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=aBBkZUCZ/0EJxZ3yNmCwBFcXFFqep/KFSI38/raVTAE=;
	b=xnvaDcv4FSEpHRGcfN94eQk6qJIToXOMbmF5vAl8hUhD7wJ/7OjzzxjkYcgtB7/oGmyz
	 sRkkDmChiRuc1vAHG9+2JR08ReuAAsIedV2/kZCHspgT0ubSnNduGF6PIyZQM9y+IWG/M
	 dcN9ViCs8c7HiSZPMOR26V5YeXvOAAxzp+eqk9VuT1NJZrhk0X1BAGk05koTfuu9qLeUz
	 S/rdziNqiUgUjYIf1TgJ6ix4Uuv1Ygx1iOrpxqITkzu+U+XmdACjGKMAPjniJ6mvrMMBV
	 rScuVOJsFvL8x+IZohW65CIg6DFNcxmNWMeMGfpYGgixef1k8ZJUPwlU67eDSsmLKzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A3J5+wfH;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E835E606A327
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 11:26:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E835E606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A3J5+wfH
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-3861d608cdcso485529eec.3
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 03:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795519595; x=1796124395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aBBkZUCZ/0EJxZ3yNmCwBFcXFFqep/KFSI38/raVTAE=;
        b=A3J5+wfHK9RKn8RKMAiPw9GL5hB1bva68fzv41DTjUTvSXtS+JFxB1B1laQ2xTawGE
         lf6AAdTnAhCIycvQgA4Skg+T30AfJzesk8Dnbg6SiDlY4Hl9pe0fL2yWwnFqOL/iDRyh
         zs0MYQsQARp30KjEWW7e/MV/zrDnYPC+IdyRpzxttLC4irilEEB/ZH1tFqxd9V4eaIal
         pkVN5hVlG8NwPL3P3c4vsyKYOvNtir/H4okyuA8higwS33gJCmdQpauwe5mD7nmUFYBE
         jHB2HoLJO47JL0gc41HHN4Fv7WB3I0FUoNVcYIp8Bh7tpzG8iAPjZQGhbfjUkSQwJLFy
         lwaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795519595; x=1796124395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aBBkZUCZ/0EJxZ3yNmCwBFcXFFqep/KFSI38/raVTAE=;
        b=OOsKkDuEgPH+4mh7mngIClHDAV9qX69MIadpe3FKKoAQLAel5+I2VVCD7G7Wa8bh6D
         VVLIpw5v5DvzCiOg11OM/RZARN9BFFkDNT2rW/jJie2d/9bPfP9ckDBBEglFev4CpI4C
         afiQd8SxRZFoqFiNtfUinfBO45JHsz8Le/HgrFD9kq0ASs7+zdFqx3Uo/j3ylk69spBW
         PcDOoRbx+na/ZEKqCtDsg8ZjRU4NBJ3BI+D2upm8u6DW94N1Oi6Dm2pQ4dV2IsupLrbj
         yaPBjSAxy4m4NEVWcg3ArHzV2ZOHbRFdcd7BlOhAePBpYhvePA28B1zGIa0Zuk7iLhuW
         NOCw==
X-Forwarded-Encrypted: i=1; AL+hErF+pHaPtgwhg7jM8DLhJD5ygmA261j34xVIZRpeWCvV37XEvfioLWF79ekSy6meKNInKVCHh6Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z+obTo284WpKUyFfG6vmJVhmkBSVnr1YG1z2nywUCOkHgdJdFDH
	mxcqIT84p6WRcgNB8qhaCbEEIIJ8ELuLjtPlfyIpn4Y6s8qclDYvNW9l
X-Gm-Gg: AZFdTZdd1VZ+sb++GWqH80cNiblDmWvFUs4H2+apjcUcMv2a+/Hwg1hNAfm/VOb6kaK
	sNMjKUvZ1hFQEJ0D6p7r/7sDvM+Z+OLqwTqy93ogtu21aIuvbwrAZH5VsYO9qM8Wey/OsUwACtX
	Khm9lQy/8vCKMyPLG/CFdQ/IjdQam25D2V+vEzKA6T03g5VCBdKHrK8Oq3YwUpqRvRCRscTQSCv
	TgzEHp1sBj2m2mWQj8vDR9bOG7DlixenNwV9TpkFfTqUO4CA6YqWPObc38I/TJ3spC63EVLdRCs
	TUQ/QdAfYUh9+69IHy0B8vysdvPBgKR+6TaemE/7iljLATAhu0xLn/+AEhnkccLlDivz9M8yidV
	yG5ysugVUn/ojH7u4P4YzsD06vUMxdOIZEEXXvD4ySifRU1HGtd92OuL4yuAnVIZ+mxwWF8/oFP
	cfZMWmhPuijkXZ2OFPlUQipwUTSUrO0iKWOklDcUOZSrTCnRkOwDFjl9e/tZ8f4DtMBq4EoVGtU
	ic/e/Uz7rnM+mPpEKQYXuyeJlMepI2w3W8Da3FMsWRXm78i8EAje5mjZNREJdZjP0725Skav7Dh
	1aaYL42+VV0eoF3Ev6h9Y00AG/t3tOFkWKkyjXbWya6Ag2gzW5EG
X-Received: by 2002:a05:7300:1c24:b0:384:a0cb:a6d0 with SMTP id 5a478bee46e88-3856de58f7fmr24082962eec.1.1795519594859;
        Tue, 24 Nov 2026 03:26:34 -0800 (PST)
Received: from localhost.localdomain ([14.47.155.101])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38566cd4efesm46086998eec.12.2026.11.24.03.26.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 24 Nov 2026 03:26:34 -0800 (PST)
From: Minseok Kim <kor8821@gmail.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	aleksander.lobakin@intel.com,
	stable@vger.kernel.org
Subject: [PATCH iwl-net v2] ice: bound the CEE DCBX priority-group id before using it as a traffic-class index
Date: Tue, 24 Nov 2026 20:26:31 +0900
Message-ID: <20261124112631.43172-1-kor8821@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <CABBEkySNmAHTuoiC3jZqvAS31AdzMb2bHe3x0EAKQGibf0xi9g@mail.gmail.com>
References: <CABBEkySNmAHTuoiC3jZqvAS31AdzMb2bHe3x0EAKQGibf0xi9g@mail.gmail.com>
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

The CEE DCBX priority-group ID (PGID) is a four-bit wire field spanning
0..15, whereas prio_table[] is sized to ICE_MAX_TRAFFIC_CLASS (8):

  #define ICE_CEE_PGID_PRIO_0_M  (0xF << ICE_CEE_PGID_PRIO_0_S)
  #define ICE_CEE_PGID_PRIO_1_M  (0xF << ICE_CEE_PGID_PRIO_1_S)

The IEEE ETS parser in ice_dcb.c masks the equivalent nibble field with
0x7 (ICE_IEEE_ETS_PRIO_{0,1}_M) so it cannot exceed 7, whereas neither
CEE path bounds the value.

In the wire LLDP TLV path, ice_parse_cee_pgcfg_tlv() extracts each
nibble into prio_table[i] and inspects it to select tsatable[i], but
never rewrites prio_table[i], leaving values 8..15 intact -- including
the defined sentinel ICE_CEE_PGID_STRICT (15).  In the firmware AQ path,
ice_cee_to_dcb_cfg() remaps only ICE_CEE_PGID_STRICT to oper_num_tc - 1
and lets values 8..14 fall through untouched.

Downstream consumers then use prio_table[i] directly as a traffic-class
index:

- ice_vc_get_qos_caps() (virt/virtchnl.c) indexes local array
  u8 tc_prio[ICE_MAX_TRAFFIC_CLASS] via tc_prio[tc] |= BIT(i), writing
  past the end of the stack array when tc >= 8.
- ice_dcb_tc_contig() (ice_dcb_lib.c) accumulates used_tc |=
  BIT(prio_table[i]) into a u8; for values >= 8, BIT() is >= 0x100 and
  truncates to zero, causing the contiguity check to pass silently.
- ice_vsi_cfg_netdev_tc() (ice_lib.c) indexes
  vsi->tc_cfg.tc_info[ets_tc].netdev_tc with ets_tc = prio_table[i],
  reading past the end of tc_info[].

The driver already enforces this invariant when writing prio_table[] in
ice_dcbnl_set_pg_tc_cfg_tx() and at the VF trust boundary in
ice_vc_cfg_q_bw().  Bounding the PGID at CEE ingest enforces the
invariant at a single boundary and prevents the u8 BIT() truncation in
ice_dcb_tc_contig() that per-array bounds checks would miss.

Fixes: 015307754a19 ("ice: Support VF queue rate limit and quanta size configuration")
Cc: stable@vger.kernel.org
Signed-off-by: Minseok Kim <kor8821@gmail.com>
---
v2: resend in plain text only.  v1 (Message-ID
    <CABBEkySNmAHTuoiC3jZqvAS31AdzMb2bHe3x0EAKQGibf0xi9g@mail.gmail.com>)
    was sent with a web mail client that word-wrapped the diff and added an
    HTML part, so it does not apply and netdev@ rejected it outright.  No
    code or commit-message changes.

    Resent from kor8821@gmail.com; v1 came from for8821@g.skku.edu.
    Same author, switching to an address that will not expire.
    Signed-off-by updated to match the From line.

Notes on testing and tool assistance (per
Documentation/process/generated-content.rst):

- Tool assistance: Claude Code (Anthropic) was used during static source
  auditing of the CEE DCBX parsing paths, to draft the initial commit
  description and bounds check, and to run build/style checks.  All
  findings, code changes, and commit text were independently verified
  and edited by the author, who takes full responsibility for the patch.
- Testing: Compile-tested only on x86_64 (defconfig + CONFIG_PCI_IOV +
  CONFIG_DCB + CONFIG_ICE) with `make W=1 drivers/net/ethernet/intel/ice/`
  against a clean baseline build, and checked with `scripts/checkpatch.pl
  --strict` (0 errors, 0 warnings, 0 checks).  No reproducer was built
  and no runtime testing was performed due to lack of E810 hardware or a
  QEMU device model; the out-of-bounds accesses are established from
  source inspection and header constants.

 drivers/net/ethernet/intel/ice/ice_dcb.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_dcb.c b/drivers/net/ethernet/intel/ice/ice_dcb.c
index abea84f14658..a36458b01fc2 100644
--- a/drivers/net/ethernet/intel/ice/ice_dcb.c
+++ b/drivers/net/ethernet/intel/ice/ice_dcb.c
@@ -407,6 +407,15 @@ ice_parse_cee_pgcfg_tlv(struct ice_cee_feat_tlv *tlv,
 			dcbcfg->etscfg.tsatable[i] = ICE_IEEE_TSA_STRICT;
 		else
 			dcbcfg->etscfg.tsatable[i] = ICE_IEEE_TSA_ETS;
+
+		/* The CEE PGID is a four-bit wire field, so a peer can name a
+		 * priority group this driver has no traffic class for.  Several
+		 * consumers use the value to index ICE_MAX_TRAFFIC_CLASS-sized
+		 * objects, so clamp it here, after the strict-priority sentinel
+		 * above has been consumed.
+		 */
+		if (etscfg->prio_table[i] >= ICE_MAX_TRAFFIC_CLASS)
+			etscfg->prio_table[i] = 0;
 	}
 
 	/* Number of TCs supported (1 octet) */
@@ -805,6 +814,10 @@ ice_cee_to_dcb_cfg(struct ice_aqc_get_cee_dcb_cfg_resp *cee_cfg,
 			/* Map it to next empty TC */
 			dcbcfg->etscfg.prio_table[i] = cee_cfg->oper_num_tc - 1;
 			dcbcfg->etscfg.tsatable[i] = ICE_IEEE_TSA_STRICT;
+		} else if (dcbcfg->etscfg.prio_table[i] >=
+			   ICE_MAX_TRAFFIC_CLASS) {
+			dcbcfg->etscfg.prio_table[i] = 0;
+			dcbcfg->etscfg.tsatable[i] = ICE_IEEE_TSA_ETS;
 		} else {
 			dcbcfg->etscfg.tsatable[i] = ICE_IEEE_TSA_ETS;
 		}
