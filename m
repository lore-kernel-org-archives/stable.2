Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794051269;
	b=5rJtDcV4fuurXk38J5RNPhatVJO2doqaju7t2jfS3IrxbVCr/dLUZ8nThBw/3OveNGpH
	 +xd+ELiBGS8mBM8zY68B+NKsCRWaspj3/HgiplTj7oHR9vvCwhogWzdb2Xq/8/XretIc0
	 D/ZOkMeiRsUAFe8q8BRfkaHCiqiRb3AOPUyd5U59ZXPF6g+RcIGPZ6TC5Z6M2C4/mqXuj
	 usWlzDUx10BbMyEZ0kXf8nhoa9jvNWVXRuozQ+lDHxfrGd8pMCH2BmetVo4JvO1FBj1rT
	 RYoeE2/TTvxyTPXD0d3BuIlADz5iigUDBVvQGiUL+oAd+RLgWJG/SfvdwFyStzBnBFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794051269;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=WrVSJWTebXtE+tU0LnNFvBWtkbGDoltWcoJtcFiPaXo=;
	b=ZVkpVKJ0ZvJ8DNKjjglFgdqSfyNszcU8asV23ysMXxJT1FhCYKtU+WjOqvu8h+vvGciD
	 uw6xxObXsmAzwgPVfAp9aDQId5aV1DDCUAZrvdhD7X55lvHmXqMlYVVLiw0XeKI4Lr/CY
	 W0uZn/I9jt/+gPmpVVkmPWLz8rEjx90hzf152Byyo9TCRBxOSxzU+/ScDs0e2LIRWwEbN
	 v/xi4V0dw1qFCCmn6NwHZWhkJpp2mV5RyAYQbicDSSJin+NQaN/9nVeGdSV60dpMWyH8q
	 DVsiLt3R36XIY52DUYhE8gSKSF0g30VqtIJqNC8Bu+4crFp1CR/cYOkRuSyGCPVkggQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fTqVO+v+;
	arc=none smtp.remote-ip=209.85.128.178
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E441606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:34:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E441606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fTqVO+v+
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-8b30cbfa628so15988017b3.0
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 03:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794051267; x=1794656067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WrVSJWTebXtE+tU0LnNFvBWtkbGDoltWcoJtcFiPaXo=;
        b=fTqVO+v+l9zGpDJE2j6M3+FmBdSTXfasWwU4SWxtS0hOuu08+Kms2MRpWzrhhRXSLS
         04b0IvOeMIHpOFMsaCsQy7wr0c0rOfpa8RwwVuC+QVT4FKxtrSJGLK0S4mI8j1qPLDK3
         A2DLgUX0zlzJT9Hc3vINcnc/uJk4tM7dD9knnQwcfAX1UbHqKyfRiSBo01jLnr14MMye
         WShn6o4cj+AHEvzZWk6asZtTmYHsyllhtDiKtn3nxRoKdx+5LhTwpV3upIldocSZtFtn
         ToYThxDLs/MJzC0RUK35jK3wiSDQ+A7z0JwH11C9GA13jcKGGvfgU4LkcGDh87If2s7i
         qBxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794051267; x=1794656067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WrVSJWTebXtE+tU0LnNFvBWtkbGDoltWcoJtcFiPaXo=;
        b=FCzLMuYF3Lc5/CRvsk+arR2SphzFdMm7qMZ+KJUAEIaSeX924l3IPy0hmqdgXE1DuE
         wFFWRNlRdY0f0ucVqbZQPxf7F5qDJoG06jbLBMlqqfK/Slum+amnqUN1f67ktyHkrRbh
         9d1UCr5tCbKdFwfOV7+9j3Y6EAgFJmz+WQvOTNd09EBGvYXo7NeSEDgSL+/ipdmQbydB
         peLO8y8GIFZioDe2qK/oVCn+xzAwiCc/7jEkoUiUymAstjHQxq0D8G1x/+ZZXdaoLOjD
         EdN+W/6Skx2h24EIiz+8vZxUHxH6EivNDZqQfMH2JeoVmCgnr21EGt/oPEdfVIzShpvc
         wXbQ==
X-Forwarded-Encrypted: i=1; AL+hErECCCif0VGK//lmr6autyR0eKnuVdYizNwaz6OeXt5M8n8pZMoxqjY7mInmrUV7csuo2OBL9cs=@vger.kernel.org
X-Gm-Message-State: APuU4Z/9UTO1hcr0tToO38eI6ltlzVC7C51rg99ErJUu2SxoLrbDVpba
	YA2JrnMDfmxE2kvUSRiFShFbUji0ID2UM2y4EH52RcKfcvHgBccayPEt
X-Gm-Gg: AYBFou0gCXZLY/hD9TNtEhxi2bc4dQHhTAIXUvSLxEMsocKGv48w2JQSQqNSeCSCrfE
	qwF+3cJGMUFZcotptKmN8kvIDZNYaIB5FUBPLFNBc6VJVBfLCnaYoLmSEw/j0hjbbWPrFGvBqwS
	AlxgbPtIFSrmMsTKfH045cv4Eq2/edeZaok0kAgxVDmcM+PPlgcgC8UD6xsfxEhL5KRg6UG3b0p
	wvFeU/K2gsziLyJnAzEfn9Zp9tQUMINR1C4nKOPKLZEBrmzM/LihQYPJ5kc9ASjSrNig9NfRkXT
	ElpJhS+IXjM7KKC57e+In/m/6TtAKJOd3y+Ydajw9CK+t51EU1r3Fc2n6v6gfHgStFJcuX8S8Qc
	EC9v6dp4k8Orjva2Sy3HQwgixn/UTvW5P4w+emKVSuth6hWIRMGGoDKH5UNDDrwlD3YxQ2tvw4o
	UhJsN6G0ZO4fMNohyX9/tZf8StP5Bma+LMB0XrWlVee86TrSULhl5T/G8wh7fmu5DUq5s4QjpS8
	Vu4y//eZx+mR6deDkgeUIvsSR+cOaTEMWS0bhLbhjY8lb3QTOnoq0kOcuQFnVAcki0l8O8kTJbz
	dIlawpsAWzCNB6G4tNuVlKFG
X-Received: by 2002:a05:690c:d94:b0:8b3:2d51:a839 with SMTP id 00721157ae682-8b34199590dmr32831887b3.40.1794051267434;
        Sat, 07 Nov 2026 03:34:27 -0800 (PST)
Received: from houminxi ([61.170.225.237])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b33f5f2d5dsm40084597b3.2.2026.11.07.03.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 03:34:26 -0800 (PST)
From: Minxi Hou <houminxi@gmail.com>
To: netdev@vger.kernel.org
Cc: Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Paul Blakey <paulb@nvidia.com>,
	dev@openvswitch.org,
	linux-kselftest@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v1 1/2] net: openvswitch: do not record user features when the change fails
Date: Sat,  7 Nov 2026 06:34:02 -0500
Message-ID: <20261107113403.797779-2-houminxi@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107113403.797779-1-houminxi@gmail.com>
References: <20261107113403.797779-1-houminxi@gmail.com>
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

ovs_dp_change() stores the new features in dp->user_features before it
updates the per-cpu upcall port IDs, and that update fails when the
per-cpu-pids attribute is empty or its length is not a multiple of four.
The request returns -EINVAL with the new features already recorded.

The features decide whether the tc skb extension static key is enabled,
but the code that enables or disables the key runs after the failing
call, so it does not run for the failed request. dp->user_features then
claims TC_RECIRC_SHARING is set while tc_skb_ext_tc_enable() was not
called, and a later request that clears the bit calls
tc_skb_ext_tc_disable() for an enable that never happened. That key is a
reference count shared with cls_flower, so the count ends up one short
and reaches zero while other users still hold a reference. Recirc
sharing in every datapath goes off with it, as does the skb extension
allocation in tc, in the flow dissector and in the bridge. The opposite
ordering is possible as well: a failing request that drops the bit
leaves the key enabled for good.

Keep the new features in the local variable until the request has gone
through, and use that variable for the enable and disable decisions. A
failed request then leaves both the features and the key alone.

Two other paths touch the bit without keeping the key in step:
ovs_dp_reset_user_features() clears it without disabling the key, and a
new datapath that fails after ovs_dp_change() succeeded is freed
without disabling it. Both predate this change and are left alone here.

The selftest in the next patch sends a set request that fails on an
empty per-cpu-pids and reads the features back; it fails without this
change and passes with it. The openvswitch selftest suite passes with
the change applied.

Fixes: 35d39fecbc24 ("net/sched: Enable tc skb ext allocation on chain miss only when needed")
Cc: stable@vger.kernel.org
Signed-off-by: Minxi Hou <houminxi@gmail.com>
---
 net/openvswitch/datapath.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
index b2a0b09fd4a5..00043aef2d03 100644
--- a/net/openvswitch/datapath.c
+++ b/net/openvswitch/datapath.c
@@ -1801,9 +1801,7 @@ static int ovs_dp_change(struct datapath *dp, struct nlattr *a[])
 			return err;
 	}
 
-	dp->user_features = user_features;
-
-	if (dp->user_features & OVS_DP_F_DISPATCH_UPCALL_PER_CPU &&
+	if (user_features & OVS_DP_F_DISPATCH_UPCALL_PER_CPU &&
 	    a[OVS_DP_ATTR_PER_CPU_PIDS]) {
 		/* Upcall Netlink Port IDs have been updated */
 		err = ovs_dp_set_upcall_portids(dp,
@@ -1812,10 +1810,12 @@ static int ovs_dp_change(struct datapath *dp, struct nlattr *a[])
 			return err;
 	}
 
-	if ((dp->user_features & OVS_DP_F_TC_RECIRC_SHARING) &&
+	dp->user_features = user_features;
+
+	if ((user_features & OVS_DP_F_TC_RECIRC_SHARING) &&
 	    !(old_features & OVS_DP_F_TC_RECIRC_SHARING))
 		tc_skb_ext_tc_enable();
-	else if (!(dp->user_features & OVS_DP_F_TC_RECIRC_SHARING) &&
+	else if (!(user_features & OVS_DP_F_TC_RECIRC_SHARING) &&
 		 (old_features & OVS_DP_F_TC_RECIRC_SHARING))
 		tc_skb_ext_tc_disable();
 
-- 
2.56.0

