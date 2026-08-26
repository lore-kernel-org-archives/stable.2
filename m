Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C988121ABBB
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 02:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787712694; cv=none; b=e3SOLYAltWe/rrqJdPx8oybZNJHRvK4QXIwRmFCBMFDqWxukL2xWPpTBo+qCF0CjyIhRRQVZ1HYonw9tQFnM8Cr6+IR9rxKXFpXfD0ps4UK0ARsewfipgBl+wntmMdOV82xTTNSEjBgeFwUt4ReqCE+arh6dXuFX60eQ8Y+D9p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787712694; c=relaxed/simple;
	bh=94xkAvnLmMabmgATmJMMNWRzGREe8szbBhLdQ7GGXRo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=My4vacICZsEyrC1fcXCHYKLZABH4T3noZXyE6WbSCMVNBFiSexRLdaHASZ8Eej8K3yUUENRlaSd/ezDkIYWkYQOTevJpIDXfRBMNtTq4M1aXii7zAhW43bOyMWONk/wJoeiGUUXJgzWRhGHgsORh3+P4v4EDCWkffMkQ+Sn5lW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ahvBx6aM; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ahvBx6aM"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38e58034d05so589799a91.2
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 19:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787712691; x=1788317491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ShK5TyOhCBOCjRuaFcsPnw8HbMZUB4sbslz07TTKocE=;
        b=ahvBx6aMdIKWeri02ar1VLryYA9GMkp3GC0fg4lyiGD4xlhclg81P1zM8M38bJmwng
         QAwEntIwaG0v+k1yZ+6JF9uii6xB7bCNnChg08QBzqP2Nrv3AYVZAJAkZDtBa7jmYhJi
         NBCphE1n7/tWVCfgjAPZg8i1cbWyZIqUYQCZ/7GoqBevsVp9jytD8t4VIuKJOdq7AxzI
         XUkoQk0ms+ikP+ryFUcw7qz5KxWfPDgoQ8ZfHoWnPq3lSLV2d0GRDJ345LbwUc0xGjlC
         /bbhIVCyMN4cUycUf6dsrwsJkRiopjnYgo1BaUpAd8K97dmAXgjlpRq8I18s1aBNMgUm
         /5yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787712691; x=1788317491;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ShK5TyOhCBOCjRuaFcsPnw8HbMZUB4sbslz07TTKocE=;
        b=Pg/Hcnb1yg4eT21gWEAYz+PahSVF5Ml3Pxn1QJouFIl1zffbmlfU1triCWeMA1SmiF
         RKzquH2iGBwGv/AY/bT6z4w8jLTb3HBzr86MTM+/4EwkRlRnAUqMtS/+xC6jNf95um7V
         5hLTorp9dTTLchBwIyWJQO4nlq5xsGWIr4RzUiIbIFdNIoEycLLvVw4fKTp65NTYp4Yv
         3zrd3TRY9q11hFpmLq0Kc4YoJDTiKLuIJ3zdoA7B+2YDUYmRGB4ZigqE85YDLDplvFDR
         f4rTxa1Qi7YIHYi9buiA7DOV0tyzAwXErTRRFwTJtu8yvq52A/CmLnAbDPBiJndJUCIi
         ewFQ==
X-Forwarded-Encrypted: i=1; AHgh+RqPHr8BUQLO+jjxfTGmtZqSVuJInGigm5JxkSkYZxJGtiHsJuJzNrTeLwfNBe9tZIJl1AXQLnk=@vger.kernel.org
X-Gm-Message-State: AFuF++m/YZHbQA184OablUegSpKRpMI5/Ta/l+88tOF2E2YIt2wzz7ag
	8/iQDcI9UrVmv0cg5+mTohR9YcMRPeNtNDeYeZiHLshGvjOD044v9fsP
X-Gm-Gg: AR+sD11nF0waPJNlVsxLIg7I2t1O1ujWo9djxjC0biyjBdlakdr8QmxoG2mUGU17zDq
	EyofuxKriA3z3HpOpslvRt8FxQx3Cpv9euWJht4s+j0znIPusa7PdtH9LBBLmvAFX3x3OFiygbB
	u0LR5gHMRTJFSaqnQrocUYReuSuH1aHoZvy/xMbdnFPfmGueL7z6V90jmJdkYviGYjSMeksnoSp
	V2OujQ+q7VkN39v8cHIN4C4srxfgrhVy93ylE0ZMtvHoXGu/ydBQ14ka6coOrTUKXTGE+tWbDks
	bEVECoYO3wGDrbjVceUNYtz/+iu/pSnWfBObuoz9Da7oZTKDzDMqcafrlgrxFPAn568+gLRC9o2
	9JxqbZjq/hFaXsQVmQ9qLtg9Y2OJIdcvhfOvBohvoRuAab73omwfvGfB5sNXqjgQRJvLy3qj0gh
	npYXEi87oOVvdcHlTK1PCQTh9pwI7w8HLWQnBuGB9339HRPED76yLNruFszju0XaGzqy2m9kbX7
	JAsVMlYGTrwJbQg94Y71e4Hz8Vc
X-Received: by 2002:a17:90b:380b:b0:366:3517:1aa2 with SMTP id 98e67ed59e1d1-3966d002fffmr7293811a91.0.1787712691017;
        Tue, 25 Aug 2026 19:51:31 -0700 (PDT)
Received: from localhost.localdomain ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396686e8e74sm2039520a91.1.2026.08.25.19.51.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 25 Aug 2026 19:51:30 -0700 (PDT)
From: Aohan Mei <ljp1205831794@gmail.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Cong Wang <cong.wang@bytedance.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Aohan Mei <henrymei@tencent.com>,
	TencentOS Corvus AI <corvus@tencent.com>,
	stable@vger.kernel.org
Subject: [PATCH net] net/sched: cls_flower: validate mask pointer after nla_next()
Date: Wed, 26 Aug 2026 10:51:20 +0800
Message-ID: <20260826025123.62758-1-ljp1205831794@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aohan Mei <henrymei@tencent.com>

fl_set_enc_opt() iterates the key's nested tunnel-option attributes
with nla_for_each_attr() while advancing a single mask pointer via
nla_next() at the bottom of each loop, so the mask cursor is driven
by the number of key attributes rather than by the mask's own
attributes.  The nla_ok() added by commit c96adff956191 ("cls_flower:
call nla_ok() before nla_next()") only validates the mask pointer
that was just consumed; the pointer produced by nla_next() is used by
the next iteration (fl_set_geneve_opt() and siblings) without any
validation.

The mask's nested attributes are validated with NL_VALIDATE_LIBERAL,
which merely warns on trailing bytes that do not form a complete
attribute.  A mask carrying one valid attribute plus 1-3 residue
bytes (or a non-aligned attribute length making msk_depth negative)
therefore reaches the next iteration with msk_depth != 0, so neither
the !msk_depth check in fl_set_enc_opt() nor the !depth check in the
per-type helpers fires.  nla_type() then reads past the mask payload
and nla_parse_nested_deprecated() iterates with an nla_len taken
from those bytes, reading well beyond the mask attribute (KASAN:
slab-out-of-bounds read in __nla_validate_parse from fl_change()).

Validate the advanced mask pointer as well: when the mask is not
legitimately exhausted (msk_depth != 0) and the new pointer fails
nla_ok(), reject the filter with -EINVAL.  An exactly exhausted mask
still skips the check, preserving exact-match behaviour for the
remaining key attributes.

Fixes: c96adff95619 ("cls_flower: call nla_ok() before nla_next()")
Reported-by: TencentOS Corvus AI <corvus@tencent.com>
Cc: stable@vger.kernel.org
Assisted-by: CodeBuddy:Kimi-K3
Signed-off-by: Aohan Mei <henrymei@tencent.com>
---
 net/sched/cls_flower.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/sched/cls_flower.c b/net/sched/cls_flower.c
index 0e275b58151c..1cefea571efd 100644
--- a/net/sched/cls_flower.c
+++ b/net/sched/cls_flower.c
@@ -1703,6 +1703,11 @@ static int fl_set_enc_opt(struct nlattr **tb, struct fl_flow_key *key,
 			return -EINVAL;
 		}
 		nla_opt_msk = nla_next(nla_opt_msk, &msk_depth);
+
+		if (msk_depth && !nla_ok(nla_opt_msk, msk_depth)) {
+			NL_SET_ERR_MSG(extack, "A mask attribute is invalid");
+			return -EINVAL;
+		}
 	}
 
 	return 0;
-- 
2.43.7

