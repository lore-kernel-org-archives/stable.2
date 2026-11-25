Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795606363;
	b=C1HrqUOwWLiXNfpKoMN7nZx1ATo+eXMMFLYH/rTp2DWTnOGEjK6FKge57zKLKAmZOJfy
	 jjWRNMzrnTEOsSMSlmss9HRjpeDheQZ9KuJXfe0+bwTpKO07COorf1z6JmARGKEdUIzHg
	 HswJJA/AUXgRVDJPPzblGXDLa0yK1Qg8leFLyjAfB8RHsA5Z+H2hpacFB+O16QDapxuiv
	 jujTmH6s+lNV5nQNRM3cgIrJprt0SVx5b2c1lY3cL4aH0KXOUiQnOSEbCmomrC8UUcFmQ
	 bDxSjhTUIrsp/E7fJuzlL7uCqHXLbP1kofGqtBiw4HggXp0d1RUDuhi1reb5beByXVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795606363;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=/8mK9Pc/LwL3p0KdETOPDtZzeFtwrz4pl0i0E317N2o=;
	b=dWCQqn7wI36HMgxRncIJ3QEH07+LAjCTr+e8ymMSClK9wJ/aSCBKVKrrQk+Ghb75UDfN
	 qGpmbpvFL5I6wXykDEoq1Uld2L2/y+t8d1Z5ueWCthszu2Kfu4KWc2HrcFYR4Il2nCfnf
	 GUl4AjvGwUdmud3Mrugy5wzWrBid/3mQBmUxML5KipH9JCSY9y1m2FbVzRylJneDIEFjR
	 PWDzYrH2HwMsALO0NjecDeR1aWaAJUqKo1zbyBcR0AP+49Jg3HTRqkjc+0NBw/HKb4dtz
	 R2haDlF2w8wsjq3E4sOyu7lJp2CjvT4fi6BCZJbo3OLwnNdlH4BSxZHiL4lzjxK0dgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RPt1ggji;
	arc=none smtp.remote-ip=209.85.216.53
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D42606A33B
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 11:32:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32D42606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RPt1ggji
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3b083afebe4so649873a91.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 03:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795606361; x=1796211161; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/8mK9Pc/LwL3p0KdETOPDtZzeFtwrz4pl0i0E317N2o=;
        b=RPt1ggjiXdimJkyKblSnhqJL9IgtT1Q+SUTHoo60I07RkTL1MO5AXwkHdza01sXsvd
         Ni3mvlFWMWLBM3Qrh8kAEoJ+REuu4PkbZkv9TJouP0kNg3pFWJ87t+2XlMS+R4zhP+hh
         ivVFA9S9Jt511hB9HpSWTPcrXQ/36hczJEwMyKCVhr86fdwpGc5mJoZ7svu6tmUPSL/W
         O/3dYosqNg4JmT3HxEbSxv3138wmyGW/GvNxTf+GOUzRTGJNw6oGEp3n+OTskNF0Xui7
         LTr8fJYyaVoh7pIXwufM4DwNs971V/jjPPRuf7tar/xDZS9ZeaUW6nMzOLkajoq8s8pg
         2UFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795606361; x=1796211161;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/8mK9Pc/LwL3p0KdETOPDtZzeFtwrz4pl0i0E317N2o=;
        b=Dw8/8F52ws0lO8okLq7vYw/4H/rUVZk+6IioOMwCeZBSr/9J1Tuh4POVPDsgsNFy+k
         Gevo1vbB3qlcRBEaYfCmZn4xyfYVXDtLNffz8wUxFyeRQNoFd/pk3bMfVfmVgFQVxeTM
         yfbbfTFE9N0+sUjpMzKkZ9rUglNhfr8uDWmW6WIqNzD+7VE4R8lmRz68mv5WanP4BwMn
         Ua61CSWaW0lI6aopq2kARFBAhyJnBDwvGC1mKYAgujU2oilw2uzOREwWC3Yo+51UXAKE
         nghoB0t3fSVnpFlBMp9I63C/K5u0LJ9XHIuDaScbAvRHHXlpwwBp9OSBy8N4z3epeP01
         goMg==
X-Forwarded-Encrypted: i=1; AL+hErHgtk4+HBsoRItE78j7TDjy/0ipqKLn+RMzQfZNRGEUK2Pwu2q/UCtN/g2/RRyABsOwpmyp2gM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8SegphO5rkEnD+cA+ap3ClpIDx3rqxmsnRSCJukZtOHYyiQd7Q
	GDWuxiJIs2lJd3k1i/vaF+f4S25kvvMYD45974ETKRr3PXU+ZsXhSz1k
X-Gm-Gg: AZFdTZckOd87mcfelbzGh3vRo2vnOiYOPNFBarrUCKCAjf7cuHQ5xJa5H3pOSRyduYW
	c1Xa7P2tXb8Z8yCbim9E0MFfq8i3gptZJMGwx2BvIY+giSR8NBsZyO55VTmGB872/Vg4nHZ3igf
	mQ3axMWfAxmrq1capHGvopiLjGQmCzPA8ugqcv3tg8ocBfwnLwmR8gHV/W3OEZElPBjcijV5SQI
	PBfE5nduGg/5h0TfyPPum2THQTCZPbfTTLVr5Dr3+SbA5nRC+JZqqnSpERstQZt/typYzAUb+ss
	UFiskbNJ4zppnkNOsQryaH+t37TO05FUshl0qkMSQo6+/jEHeGsnlcPG3/+klqlFwSCer/V+u9K
	NC/Ywiy9ednWqqh3lpd189bsIv5u3DumEAPVsX/2gH+esCEoYBDpKv5pDv4HOxVTHWlhMhWF/gw
	4X/3q3bWl36kCraLjnNUB0BZ66tJTl//CV2CF5k10Lzz2NXbbGme41OZU60TeKYyOr3iqA8ePcc
	iF4jNWMEn48dqAHfqer9HBKTUR7Mx8hqtmeXrf92/lMJtqQW1ORt76bXNSf3eGAGDHpIWrbJ8dB
	ZYNqXMPc5gtuShLxbhtgmckyVsnSH9yblajCAPftgQgAmyP6E1YU
X-Received: by 2002:a17:90b:4a48:b0:3b0:9984:18c6 with SMTP id 98e67ed59e1d1-3b41c907e3bmr26052479a91.3.1795606361341;
        Wed, 25 Nov 2026 03:32:41 -0800 (PST)
Received: from localhost.localdomain ([14.47.155.101])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41aab4729sm27132863a91.0.2026.11.25.03.32.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 25 Nov 2026 03:32:41 -0800 (PST)
From: Minseok Kim <kor8821@gmail.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	przemyslaw.kitszel@intel.com,
	aleksander.lobakin@intel.com,
	stable@vger.kernel.org
Subject: [PATCH iwl-net v3] ice: reject an out-of-range CEE DCBX priority-group ID
Date: Wed, 25 Nov 2026 20:32:37 +0900
Message-ID: <20261125113237.48372-1-kor8821@gmail.com>
X-Mailer: git-send-email 2.54.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

The CEE DCBX priority-group ID (PGID) is a four-bit wire field spanning
0..15, whereas prio_table[] is sized to ICE_MAX_TRAFFIC_CLASS (8):

  #define ICE_CEE_PGID_PRIO_0_M  (0xF << ICE_CEE_PGID_PRIO_0_S)
  #define ICE_CEE_PGID_PRIO_1_M  (0xF << ICE_CEE_PGID_PRIO_1_S)

The IEEE ETS parser in ice_dcb.c masks the equivalent nibble field with
0x7 (ICE_IEEE_ETS_PRIO_{0,1}_M) so it cannot exceed 7.  The CEE wire
parser does not: ice_parse_cee_pgcfg_tlv() extracts each nibble into
prio_table[i] and inspects it to select tsatable[i], but never rewrites
prio_table[i], so values 8..15 survive -- including the defined
strict-priority sentinel ICE_CEE_PGID_STRICT (15), which is not a
traffic class at all.

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

Validate the whole Priority Group Table at the TLV parsing level, before
any part of the sub-TLV is applied, and reject it if a PGID names a
group this driver has no traffic class for.  Values 8..14 have no
meaning in the protocol, so there is nothing to translate; refusing the
peer's PG configuration is the correct response rather than substituting
a value it did not send.  The strict-priority sentinel 15 remains
accepted, but is now replaced in prio_table[] once its meaning has been
recorded in tsatable[], so it no longer reaches the consumers above.

The four octets inspected by the new check are already read
unconditionally further down the same function, so this adds no new read
of the TLV.  The rejection is silent by design: the input is attacker-
controlled LLDP, and the other parsers in this file do not log either.

The driver already enforces this invariant when writing prio_table[] in
ice_dcbnl_set_pg_tc_cfg_tx() and at the VF trust boundary in
ice_vc_cfg_q_bw().

Fixes: 0ebd3ff13cca ("ice: Add code for DCB initialization part 2/4")
Cc: stable@vger.kernel.org
Signed-off-by: Minseok Kim <kor8821@gmail.com>
---
v2: https://lore.kernel.org/intel-wired-lan/20261124112631.43172-1-kor8821@gmail.com/
v1: https://lore.kernel.org/netdev/CABBEkySNmAHTuoiC3jZqvAS31AdzMb2bHe3x0EAKQGibf0xi9g@mail.gmail.com/

Sent stand-alone rather than in-reply-to v2, as requested.

v3, all of it from Przemek's review of v2:

- Reject instead of clamp.  v2 rewrote an out-of-range PGID to 0; v3
  refuses the Priority Group Table outright.  The check runs before any
  field of the sub-TLV is committed, so a rejected TLV leaves the
  existing ETS config untouched instead of half-applied.

- Moved entirely to the TLV parsing level.  The ice_cee_to_dcb_cfg()
  hunk from v2 is dropped; only ice_parse_cee_pgcfg_tlv() changes.

- Retagged Fixes:.  v2 cited 015307754a19, which only added the
  ice_vc_get_qos_caps() consumer in v6.13.  The unbounded parse is from
  0ebd3ff13cca (v5.1), so stable trees older than v6.13 need it too --
  ice_vsi_cfg_netdev_tc() and ice_dcb_tc_contig() predate the v2 tag by
  years.  Thanks to the sashiko.dev report for catching this.

One question left open from the sashiko.dev report, deliberately not
addressed here.  It observes that in ice_cee_to_dcb_cfg() the
ICE_CEE_PGID_STRICT branch assigns cee_cfg->oper_num_tc - 1, which is
out of range if oper_num_tc is 0 (underflowing to 255) or greater than
ICE_MAX_TRAFFIC_CLASS.  That is a real gap, but its inputs come from the
Get CEE DCBX Config admin-queue response rather than from the wire, and
that path has no TLV parser to move a check into -- so I have left it
alone per your "here we should have no changes".  If the AQ response is
not considered a trusted source, I am happy to send a separate patch
bounding oper_num_tc where it is consumed; please say which you prefer.

Notes on testing and tool assistance (per
Documentation/process/generated-content.rst):

- Tool assistance: Claude Code (Anthropic) was used during static source
  auditing of the CEE DCBX parsing paths, to draft the commit
  description and the check, and to run build/style checks.  All
  findings, code changes, and commit text were independently verified
  and edited by the author, who takes full responsibility for the patch.
- Testing: Compile-tested only on x86_64 (defconfig + CONFIG_PCI_IOV +
  CONFIG_DCB + CONFIG_ICE) with `make W=1 drivers/net/ethernet/intel/ice/`
  against a clean baseline build, and checked with `scripts/checkpatch.pl
  --strict` (0 errors, 0 warnings, 0 checks).  No reproducer was built
  and no runtime testing was performed due to lack of E810 hardware or a
  QEMU device model; the out-of-bounds accesses are established from
  source inspection and header constants.

 drivers/net/ethernet/intel/ice/ice_dcb.c | 39 ++++++++++++++++++++++++++++++--
 1 file changed, 37 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dcb.c b/drivers/net/ethernet/intel/ice/ice_dcb.c
index abea84f14658..86bdaece4cfd 100644
--- a/drivers/net/ethernet/intel/ice/ice_dcb.c
+++ b/drivers/net/ethernet/intel/ice/ice_dcb.c
@@ -356,6 +356,20 @@ ice_parse_ieee_tlv(struct ice_lldp_org_tlv *tlv, struct ice_dcbx_cfg *dcbcfg)
 	}
 }
 
+/**
+ * ice_cee_pgid_is_valid
+ * @pgid: CEE priority-group ID as it appears on the wire
+ *
+ * The CEE priority-group ID is a four-bit field, so a peer can name a
+ * priority group this driver has no traffic class for.  Only
+ * 0..ICE_MAX_TRAFFIC_CLASS-1 and the strict-priority sentinel
+ * ICE_CEE_PGID_STRICT are meaningful values.
+ */
+static bool ice_cee_pgid_is_valid(u8 pgid)
+{
+	return pgid < ICE_MAX_TRAFFIC_CLASS || pgid == ICE_CEE_PGID_STRICT;
+}
+
 /**
  * ice_parse_cee_pgcfg_tlv
  * @tlv: CEE DCBX PG CFG TLV
@@ -374,6 +388,21 @@ ice_parse_cee_pgcfg_tlv(struct ice_cee_feat_tlv *tlv,
 
 	etscfg = &dcbcfg->etscfg;
 
+	/* Several consumers use prio_table[] directly as an index into
+	 * ICE_MAX_TRAFFIC_CLASS-sized objects, so reject a Priority Group
+	 * Table that names a group outside that range before any part of
+	 * this TLV is applied, rather than substituting a value the peer
+	 * did not send.  The four octets read here are already read
+	 * unconditionally below.
+	 */
+	for (i = 0; i < 4; i++) {
+		if (!ice_cee_pgid_is_valid(FIELD_GET(ICE_CEE_PGID_PRIO_0_M,
+						     buf[i])) ||
+		    !ice_cee_pgid_is_valid(FIELD_GET(ICE_CEE_PGID_PRIO_1_M,
+						     buf[i])))
+			return;
+	}
+
 	if (tlv->en_will_err & ICE_CEE_FEAT_TLV_WILLING_M)
 		etscfg->willing = 1;
 
@@ -403,10 +432,16 @@ ice_parse_cee_pgcfg_tlv(struct ice_cee_feat_tlv *tlv,
 	ice_for_each_traffic_class(i) {
 		etscfg->tcbwtable[i] = buf[offset++];
 
-		if (etscfg->prio_table[i] == ICE_CEE_PGID_STRICT)
+		if (etscfg->prio_table[i] == ICE_CEE_PGID_STRICT) {
+			/* Strict priority is carried by tsatable[].  The
+			 * sentinel is not a traffic class, so replace it
+			 * instead of leaving it for consumers to index with.
+			 */
+			etscfg->prio_table[i] = 0;
 			dcbcfg->etscfg.tsatable[i] = ICE_IEEE_TSA_STRICT;
-		else
+		} else {
 			dcbcfg->etscfg.tsatable[i] = ICE_IEEE_TSA_ETS;
+		}
 	}
 
 	/* Number of TCs supported (1 octet) */
-- 
2.39.5 (Apple Git-154)
