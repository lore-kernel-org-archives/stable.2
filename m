Received: from mail-yx2-f40.google.com (mail-yx2-f40.google.com [74.125.224.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA43652845D
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 15:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790868736; cv=none; b=Cgr7Dgp3oW9sfCtAkXJ7RSwqk8Z9ekuBDP8FCoThBc/mr8p0pvLTULWxGSQtZQrgLm3meDLftTpgnHJ6K3fWTXShwAWNrzVKuZTuI8XzwegLdLvy2d2BdwJoVl8TVDbUzY8vrMekYrwRx5nlU49FiW6MzK1XbPruoqmvMLe19is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790868736; c=relaxed/simple;
	bh=awPd430K7tvGhVtyXPwAmbf2+LPoDRBKF7lw1teNL/g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rQEFpL2Tn7c/InCMRPUQLLbQd0E/hOWQE23Vvas5xrXgcCvWvzIA6yNAofYkgC8ZgsvwRKuX5GE/pnDr5A/Wy05X/FUhMcGA5hWFxbXkTT8uozd/ihGmEPxqccL96TE/Dz14+zxaSIQ8i9CPbZajKFQ42n6VO5Ow1HtIi5tLKt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=eV7eeuE6; arc=none smtp.client-ip=74.125.224.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="eV7eeuE6"
Received: by mail-yx2-f40.google.com with SMTP id 00721157ae682-8ab445ac183so39668767b3.3
        for <stable@vger.kernel.org>; Thu, 01 Oct 2026 08:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1790868733; x=1791473533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=B9KRC60eFYvt53Jmqs4DofnspBBJHdkc+l+n5E9GJWo=;
        b=eV7eeuE6xT+0koCYiaGSPYb0Kg7X7hmqxeZ/M8XgfcmUleWt7wedv1Vdp55sMuoco0
         vhfg3F0DWmkzpVvgn9UsHDYaayEe79CKEwHIZA1yE3ifMsVOWGGYkMiyDTy6UTphftTx
         UWqu94qASnfEUXjFNh4Zj1UhLmBcED+lLLF4o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790868733; x=1791473533;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B9KRC60eFYvt53Jmqs4DofnspBBJHdkc+l+n5E9GJWo=;
        b=sAafYDwHwmtGW/2eb3+3Yae7q2O4pYOHvpVXJs1xVw30oebjiNvQOsMVSRr+/yp+Gy
         E4beQ/hsFmdysFyUZxYsI5zLzfudE2DWqsYqTUW2KxqyUrdYUsXMFA1R62QQx0XDmzz3
         0eadEeSXMJT8IK4VNswbMiAl4ozZ2V+TY/m7ODff+puOdaq3zA0uJ5BdCSSMtRYJD2yJ
         CsWrwv8LEPkNzxF96z7z/wxdqV/RFH8yrRMChVSTxUb2uDC+Sj0A45OUWpuM7UIVblq4
         MHgs44/4N9kx2HLt9WsWsK8fu/SkfGRZc16DzWa6FSPi5une6nplDRMbaRNtBRF3X81B
         bPVw==
X-Forwarded-Encrypted: i=1; AKwUvBy1jtJnV2QbUHRNt1YjkmeKechqMkmOSxxm6AdVJVrIqMv08JdeyNNouOMIpsxseLV3ebWSqU8=@vger.kernel.org
X-Gm-Message-State: AFq9FYLZlMQCtn2aLVKvDhVDc5icdndYpZynB2aVSfxjzNnCOB+LpoXN
	H7MwBJ/4orWk909ZKfluP4YgZElDmCl5sjOez00TpU0PQRCN+PYD2dzr/Ft25DOGQg==
X-Gm-Gg: AYBFou0enFnVdYsaY/+J86drOz+LsNo4Hk0K75XH20jByg/kj2t4FOVUhLWQi1wctMn
	ZkJHMpydddYxNkEnnWeHR5RN/3urY2rsFua+mdQGVRf9M6CAWHGcADPV01N+yBZ7knI7uhZeLIj
	rrA4SjaKzMZ471u64qawo/dzv1XFWzTgEey/hrUbf4d668HXWjmjz05U5CxgdBHsYKdBZGUXZck
	KO6lBLGagDQeAlPaUd69vAsHzcoRlmFpNOdthiWFs332DeJ4pacHZAYsThMQamLzbVGUPQW7cRc
	wvVpNPHsk0VQwPAH4Z2Q5dWMozBv4+k09dyr1gGMIpnSVjdMaCr6G46DW57Q2UsyyGbddj9YJso
	VjVK+I90vSWRwgxWNMHXcuEk4M0UsH7KUgWpanzr7P4KS6hJmxBNDsADSGnRkP5qBfwn06dRnLJ
	BeZ9G81TWtPsg7tgRo32DchKhHItX/FYpAh7BfNLIba+SRoNgs1L591BQybhdFSsWrkX0cdW27b
	fQ9
X-Received: by 2002:a05:690c:113:b0:8a9:8021:5cd1 with SMTP id 00721157ae682-8ac908d539cmr25909637b3.6.1790868733308;
        Thu, 01 Oct 2026 08:32:13 -0700 (PDT)
Received: from exu-caveira.tail33bf8.ts.net ([2804:14d:5c54:4d67::2000])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8acdad046b1sm12059277b3.30.2026.10.01.08.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 08:32:12 -0700 (PDT)
From: Victor Nogueira <victor@mojatatu.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	netdev@vger.kernel.org
Cc: horms@kernel.org,
	Eric Dumazet <edumazet@kernel.org>,
	stable@vger.kernel.org,
	hybris <hybris@mojatatu.ai>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH net 1/2] net/sched: cls_route: reject change with no routing attribute
Date: Thu,  1 Oct 2026 12:32:00 -0300
Message-ID: <QDISC-0JB3.v1.20260929143022@mojatatu.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

route4_change on a filter change that supplies no routing attribute
at all (no to/from/iif) reaches route4_set_parms with fold set, so the
handle-mismatch check -- which only fires when creating -- is skipped.
nhandle is built as the all-wildcard bucket (0x8000 | 0xFFFF << 16) and
the filter is rekeyed to 0xFFFF8000, so the handle userspace already
stored no longer addresses the filter. (The netlink reply carries the
new handle; what goes stale is the handle the caller holds.)

The rekey actually misclassifies the packets. The new handle's from_hash
is the wildcard chain (route4_hash_wild), whose filters route4_classify
applies without any id/iif comparison, and its bucket (256) is reached
by every packet through the h < 256 restart. A filter that matched only
a specific realm therefore becomes an unconditional catch-all that applies
its classid and actions to all otherwise-unmatched traffic.

Reject a change that would rekey the filter this way, with the
routing-attributes-required error. A change that names at least one of
to/from/iif, and an in-place replace that keeps the routing identity via
a supplied attribute, are unaffected. A change of a filter that already
sits at the wildcard handle is a metadata-only update and remains valid,
so only a change that actually moves the handle is rejected.

This is a follow-up to commit 41e85e54e564 ("net/sched: cls_route: Fix
in-place replace"); this patch closes the no-routing-attribute variant
that the parent series did not address.

Conditions to recreate the bug:
  tc qdisc add dev lo clsact
  tc filter add dev lo ingress protocol ip pref 100 route from 1 to 1
  tc filter change dev lo ingress protocol ip pref 100 handle 0x10001 \
      route classid 1:2
  tc filter show dev lo ingress   # handle became 0xffff8000; iproute2's
                                  # stored 0x10001 no longer addresses it

A change of a filter already at the wildcard handle, e.g. one created by
"tc filter add dev lo ingress protocol ip pref 100 route classid 1:1"
(iproute2 defaults the handle to 0xffff8000), stays a valid metadata-only
update.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260907192133.2639067-1-victor@mojatatu.com
Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
---
 net/sched/cls_route.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/sched/cls_route.c b/net/sched/cls_route.c
index 0f211f030fd9..dca812a75269 100644
--- a/net/sched/cls_route.c
+++ b/net/sched/cls_route.c
@@ -434,6 +434,12 @@ static int route4_set_parms(struct net *net, struct tcf_proto *tp,
 	if (handle && (!fold || nhandle == (handle & ~0x7F00)))
 		nhandle |= handle & 0x7F00;
 
+	if (fold && !tb[TCA_ROUTE4_TO] && !tb[TCA_ROUTE4_FROM] &&
+	    !tb[TCA_ROUTE4_IIF] && nhandle != fold->handle) {
+		NL_SET_ERR_MSG(extack, "Routing attributes required");
+		return -EINVAL;
+	}
+
 	if (handle && !fold && nhandle != handle) {
 		NL_SET_ERR_MSG_FMT(extack,
 				   "Handle mismatch constructed: %x (expected: %x)",
-- 
2.43.0

