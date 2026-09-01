Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DC039C63E
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 01:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788226173; cv=none; b=PzvIAVu/zV1Yxa/yjrF8KW5rIUkFWe9+xYJDqXa4d2gZg4MDnvMfnpk3Uf9Nwbcy83V41miFOYyHzpEdq+kbyNVt6qsQJdgLXHnuZTMIN97MdOAidHYYmBznOLkTDVJdQ8ZCp2UQfkJ4yAqtFAkq2hZPQiNJmO3Bsjxpmw506iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788226173; c=relaxed/simple;
	bh=npzZe06PtobvJpaMjSbQwwuI2JcJx4uej0mJwKkmuwE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hKPfPAQOpQ1UiQOOk1LIElGYULbQ1bGPORGAkYU0x1o/dudLeBFrvOwQFVSu/NeC7PJS+5YYx1cc6jtbLzw+q1CMHOW8doV8bM3UGnIAlHdhVNx/sw5s4yIDjp1866j7G3D0xRUSnw6il7+tfy3Ar4uVef1orKEZjosXwdAWo0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=MFiGOiBK; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="MFiGOiBK"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-39266382df6so3552342a91.3
        for <stable@vger.kernel.org>; Mon, 31 Aug 2026 18:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1788226170; x=1788830970; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ijPMp0aoruOjxz0EUwVJJByK31zD+FexQPaTyeeUmWw=;
        b=MFiGOiBKMr0NL6Vm/6oJ7ZF6sbI1qGwhY728k6V4AyiyCbdriB/gR8mLEF6otwkf7s
         q72iR1XxoqvqKHA19IAswtmfWXJZBdPC2ZdaZZaBCm1FAVH8+jNh1Pu5DdjUXQJkstL3
         LuD2Vbe6GkBOawNNtL5D7Mpa+kzGa9jlDlJZQGp/IQw8Vjm2Kr78c9YxWikWBe8CroJD
         cRLLiB90zL7hHGqoVI3vtYoC9IXrhtd5eU7qBhrGgdjAR+XarsXjCMbx8roitQhzIw3w
         ZQtoFVSU0WBHmYHWfIoCJV23DyoA0huair2U1nBPkXWb1LGLIlMOfoIKuOcDxQGWUuIp
         8JXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788226170; x=1788830970;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ijPMp0aoruOjxz0EUwVJJByK31zD+FexQPaTyeeUmWw=;
        b=VmJu6kp5nEbJ3TTCR9RpGr1rLHkXmyqv4p7dfzauJj+KFJ3QYHDHsH5SD5idj2Pu22
         0LNsl8QNJCbeLk65iokmLAtM/E3BfR655LkDK+95uVOzeqV/Y+nG76yf/ZN0EwaWLboO
         gsLJYV5aFqydOP+zdLVa/R1cf3HOlzKu8MUlj8S855cY5Q3XwU6o1M/lFvUeXskqzU6H
         RTvwepRs9fSpZJiVOgqOsxISabHsfyr1sdrHykgGGTy2AHvnOGwemvsgymAnnNiGo5t6
         BmG0dcJBTHpXEa1ioIL4gbW3NLLONMRmdXkrBnm4PJYK4ZhwkqXFeTduPJN9DQhNHGVY
         XrGg==
X-Forwarded-Encrypted: i=1; AKwUvBwVSzQH5i6048KJg0PpvQiMEb6aR62rtfMKWopsdYRKkL3MO2yciXDqgNLkMS6DvFFCeMy9rqw=@vger.kernel.org
X-Gm-Message-State: AFuF++mCP8CtlLPbxmRaWlNVi4bBOKiht5JFv3iFjaKD104+nrRD/y5W
	2ZoHCfKmVB36/Y7jmmc9UJ/904qq7BZ8DVxCM4XMVwesf6miYrEdL7cRzCeZdp0Sz/8=
X-Gm-Gg: AYBFou3cccSYJEdbtMlti8kxkU5xQluO/1mhSOlfzpUBZduwGNWD1tRf72mIRW6DpIn
	ILypAld2ccGXWTz3lko7QreJrZ4ttHNeLOOtDUIOZhx9PN0KuCtrZWwpbJai+Y68mF2fVR/BgZc
	w21K1V18MCb3FRwPdKumA26uN1LarnvuZWO1hwcuU+5Z8uicbq+l+bz+W1sL4091tiIhaFDY/hJ
	n65mJa7bphFIkUtXSeAG9gdEl1cHMKV+9WwShFVLn1aAi+dyvkIsFLI29BjkJZkZSH8tuVFgZPR
	SN3iaa5363PmMOQnPHZIopUuHqd7CQTkoGBUX+yuGfyxevuTwVQ7MlpkyrMI96/lc7Y6Wp2pJOS
	b+qkNTp50Y6EgqezOv0fwsQzajKixSqA/P8Mc+Hc9yHgRWbGUgJDynDA0RfgI2hK/DvDF5WdYiU
	+/IS1Rj4JitTrSMMRqonfau4nDKQUJGSqnzPySMsk1rMuDKFbYDUlZ26OHNOAYQGw=
X-Received: by 2002:a17:90b:3c05:b0:396:5cdc:4bea with SMTP id 98e67ed59e1d1-39907ab0955mr6015192a91.5.1788226169561;
        Mon, 31 Aug 2026 18:29:29 -0700 (PDT)
Received: from [127.0.0.2] ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32b5bef7683sm19390817eec.12.2026.08.31.18.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 18:29:29 -0700 (PDT)
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Date: Mon, 31 Aug 2026 18:29:22 -0700
Subject: [PATCH v7 04/10] of/overlay: put property on deadprops only after
 changeset add succeeds
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-nh-of-alias-overlay-v7-4-02754604805a@nexthop.ai>
References: <20260831-nh-of-alias-overlay-v7-0-02754604805a@nexthop.ai>
In-Reply-To: <20260831-nh-of-alias-overlay-v7-0-02754604805a@nexthop.ai>
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, 
 Frank Rowand <frowand.list@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Shawn Guo <shawnguo@kernel.org>, 
 Grant Likely <grant.likely@secretlab.ca>, 
 Grant Likely <grant.likely@linaro.org>, 
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>, 
 David Daney <david.daney@cavium.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Abdurrahman Hussain <abdurrahman@nexthop.ai>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788226164; l=1741;
 i=abdurrahman@nexthop.ai; s=20260510; h=from:subject:message-id;
 bh=npzZe06PtobvJpaMjSbQwwuI2JcJx4uej0mJwKkmuwE=;
 b=3TJqFcAxk2Dxfh5PddnOWq6tB1A1N54A3Rz65h50plOtgFUybVPiU4pyMG3NqVNXEh+GUV4Lw
 WEyTLTPXB36CaqXkj3W2Yx+T4hVMuW5xmnVB42u8FEoPnnZmz7ALp8H
X-Developer-Key: i=abdurrahman@nexthop.ai; a=ed25519;
 pk=omTm9cCAbO0ZhS32aKfJDKue0W3sQGpG9ub5eYHif8I=

add_changeset_property() links a new property of a not-yet-live
target node into the node's deadprops list before handing it to
of_changeset_add_property(). If that fails, the error path frees the
property but leaves the freed pointer linked in deadprops, and
of_node_release() frees it a second time when the aborted overlay's
node is released.

Record the changeset entry first and link the property into deadprops
only on success. of_changeset_add_property() never looks at the
node's property lists, so the order of the two steps is otherwise
immaterial, and the error path frees a property that nothing
references.

Fixes: f96278810150 ("of: overlay: set node fields from properties when add new overlay node")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-fable-5 [Claude Code]
Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
---
 drivers/of/overlay.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index 74aea704835a..284c9bc6c9cf 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -358,12 +358,13 @@ static int add_changeset_property(struct overlay_changeset *ovcs,
 		return -ENOMEM;
 
 	if (!prop) {
-		if (!target->in_livetree) {
+		ret = of_changeset_add_property(&ovcs->cset, target->np,
+						new_prop);
+		/* the detached node owns the property until the apply */
+		if (!ret && !target->in_livetree) {
 			new_prop->next = target->np->deadprops;
 			target->np->deadprops = new_prop;
 		}
-		ret = of_changeset_add_property(&ovcs->cset, target->np,
-						new_prop);
 	} else {
 		ret = of_changeset_update_property(&ovcs->cset, target->np,
 						   new_prop);

-- 
2.54.0

