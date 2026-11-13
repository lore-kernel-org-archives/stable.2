Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794601441;
	b=QnRN3J1pCvqtmrPCseo1UltvB8vJaAyxBSWwFzUEC+9ePRuX+kqiXs/Db95Psewp0Wwf
	 lIdMRKZkUBtd4+AFOyV9pW5rEDIbD8tAZnNrEzKKKaQxBldFmmGGigA5YwXrFOg1caccu
	 h1zhO6v8eQjno0lbehejz0vu7sRPesJLeXBVYEvHSTC7Rxui2kwcqcMdYGAbXQQ0evFLw
	 OtCCPYuTXDuU7PVL1NfnfcRJom6C3IZFJkJEKhZcfT97SuHu5BpvHUZKTKbxUSrPn+lTk
	 RWF10ARAj+xXpeIDrM9XwFbjkm55ymi6Oxk0jntPSsLPE6vyjMe2ZuiAQ3x5uPanOZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794601441;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=u7Jx9B4XiDyCzWqvWYy2iq25I09vd8jKOKtiPXq+9CY=;
	b=zCrIha3ej4fSRuUNJPRlLxtSroHMyqrXiOXDmUgW0tvvof9Cvgxc/esGADNLuEAulBGQ
	 FwVlW3wvDP5GenjwDo6Z8CWnu/Ur8GfQnjsYkqWluFPpNftljVl32BqPW0CORL/yH4Gj4
	 5EbeVfZJrOefBDQQ9JrtZSchN23kaIp7lPCQO2sclWdFY1xZAFzAvn81nTzETgvjXsc+J
	 LZY2QnFSzrQD+qIV4FpR1N4AdTzHjOuSY0VBASZx22UZb2/t7Wo/FCL/4hW8zuZ3OPBRQ
	 B606vMXZr9ll7OS8Sbwcf7Xr+0hgyr51Igz1mZEbC57XfRfga9YmCeKdX9QBuSufXhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YpsjCMtm;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E33E606A881
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 20:24:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E33E606A881
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YpsjCMtm
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a5b2be99a8so9115115e9.2
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 12:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794601439; x=1795206239; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u7Jx9B4XiDyCzWqvWYy2iq25I09vd8jKOKtiPXq+9CY=;
        b=YpsjCMtmCYEgPWqV+30pK7N1ZmgaoyTqGauBzlwfhSeCNLAGr2JTsjyWcQwjkuerTf
         oOqJ7kKIeDc9RxClm6MskoSOOKlqrF+a6tAbWaxr2DQH+czdaqrPCJrqgS/uLRYPUNW9
         gDHVaqqcR/PGNSQ9ksVsLEl2AsFk4Aluv6F/s7lsfpncTSnPHdKriiLafjotRrTFqSoM
         /NAoNribSHaasKcrbhYO40bnHctgDriSDtrWTAaOnrzH99oYgWVz2nfRk4s/ZeveY2md
         UYRM+1ujFTkHSmf3BxiL5udVKNgpihild2wK5OeTyCdBnjxDd9YTvkiY/8HF+UVyywhL
         OsOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794601439; x=1795206239;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u7Jx9B4XiDyCzWqvWYy2iq25I09vd8jKOKtiPXq+9CY=;
        b=qddU6C0r9Ga/aiH9vCNe83ds3uDoHX7pwzewN9AM7h4aL/u6KM+MK3b7epOPZU9P/N
         F17H7RjH8zmo0zuhE8I382d2qbUQ06d99XFjXa/RvtMrliRs+P/Yd8cTh559jSP6Om2X
         BXZmJ//ICLX1TPPXbPB9ztJDS5x9YXoeF9PPnBEfDpC5GWvYZV805BXxzoSUmu5xrz4S
         lZlFiOSQmBPdKnuuFDUm3CVwYqChvzVzr4eFklckDPsmdkQZMvRpOXGmbvEM8mbWzp//
         fbczlZy1MGk/lL7UtJBQMEbfPqr5TI8YhoUhanTQ7t5iVxv92DhQvhcAHhwELgNJSq06
         AXXg==
X-Forwarded-Encrypted: i=1; AL+hErEMXSpLrfsGSuX+FQP7+1YaY/r1KqGtI8FU556IsBJ/bhb0Mg3p3LVz6JQcQsCu0taqZF7ogPg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8xUi6VKBlt5OlOVXiF9PtE52hfsTN+3pkvBnIgpQzKoWc+FbB1
	FeVUB5GtpcvAslEOisTKR8N/uc+SwpDFNOWhptQ0Vo+P1WzN+QQ5qcmf
X-Gm-Gg: AYBFou0se2vgs7d0sbZC/fkNpJ7jpsJSyxXaHFwNPOc8OY4umtUoGqPdh9+aGatH+nk
	LzVutFslUmolOii5vGuQWdCWztWGHMKcjWV+rhHDmXhQ789gx6g9+b0qx8nxcoDM25orkJ53+7p
	oBvqSgTKsCiqBMzoum12KrGbD1iF6G3XUVvam6c+Xo5Slxic4Sh7mL2ewNEPcipZ5Y+6TT8ATCS
	BYn9Aa1b0vHNR96i7B5mWOmYx9mtusF0b/++fDWTVKBciFtE5PX0vshEhXhmlpbALtqGhAQiLur
	jrzsJ9Q0z9QK07QLTIWqXQDiyTgEGcfJhiQzJ3P7C08mK3CG5ZF8RrmgohAUr5nSkWyECKRZXn+
	3uyWHTt+eZybrDocB1qSNCSO4WxiVuV8WJFIQZmjBfFGHV6YIQH2AHR/hx50C8lsTZwcT8jSR7p
	iFB05/BQBmG4oKxFNEc6BHHZPaU5UfrMk8us6JVkkUDym4KuDnIh/y4qUDvbZjGo1ddWDI1wZAU
	8LaLn3dF1vtj01PEjhsNLvZddqvLnT5i6AlkuEOkkAnubxZS5QSDixHNu3hNpu8vKW6qozO4Cp0
	xZh/htHEsh497ZxIAeKOFPNl0W0soVJdzKN2sm+Vqpr/2pJE6QoYlQ==
X-Received: by 2002:a7b:ce9a:0:b0:4a2:392:9de2 with SMTP id 5b1f17b1804b1-4bb55a911aemr55129645e9.28.1794601438992;
        Fri, 13 Nov 2026 12:23:58 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb566a4a2csm46505365e9.0.2026.11.13.12.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 12:23:58 -0800 (PST)
From: =?utf-8?q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
Date: Fri, 13 Nov 2026 21:23:25 +0100
Subject: [PATCH v3 3/5] selftests/landlock: Test that layering does not
 break refer
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
Message-Id: <20261113-b4-landlock-refer-nonfs-layer-v3-3-02d7e42bcdfd@gmail.com>
References: <20261113-b4-landlock-refer-nonfs-layer-v3-0-02d7e42bcdfd@gmail.com>
In-Reply-To: <20261113-b4-landlock-refer-nonfs-layer-v3-0-02d7e42bcdfd@gmail.com>
To: =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
 "Serge E. Hallyn" <serge@hallyn.com>, 
 Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, 
 Shuah Khan <shuah@kernel.org>, Dwi Siswanto <me@dw1.io>, 
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, stable@vger.kernel.org, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
X-Mailer: b4 0.15.2

Regression test to exercise that layered Landlock domains do not
accidentally deny the LANDLOCK_ACCESS_FS_REFER access right.  This
used to be the case when layering a non-filesystem ruleset with a
filesystem-enforcing ruleset.  In that case, REFER operations that
would have been allowed for the individual rulesets would get denied
when layering the same rulesets.

Link: https://github.com/landlock-lsm/linux/issues/67
Link: https://github.com/landlock-lsm/go-landlock/issues/66
Fixes: fff69fb03dde ("landlock: Support network rules with TCP bind and connect")
Cc: stable@vger.kernel.org
Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 tools/testing/selftests/landlock/fs_test.c | 54 ++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index f725882fa4a7..6d9baab0fae8 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -2612,6 +2612,60 @@ TEST_F_FORK(layout1, refer_denied_by_default4)
 				layer_dir_s1d1_refer);
 }
 
+/*
+ * Regression test for layered domains: The two enforced Landlock layers both do
+ * not restrict the tested "refer" operations on their own, so they should also
+ * not restrict them when they are layered, regardless of the layer order.
+ */
+static void test_layering_does_not_break_refer(
+	struct __test_metadata *const _metadata,
+	const struct landlock_ruleset_attr *const non_fs_attr,
+	const bool non_fs_first)
+{
+	ASSERT_EQ(0, unlink(file1_s1d2));
+
+	if (non_fs_first)
+		drop_access_rights(_metadata, non_fs_attr);
+
+	enforce_fs(_metadata, LANDLOCK_ACCESS_FS_REFER, layer_dir_s1d1_refer);
+
+	if (!non_fs_first)
+		drop_access_rights(_metadata, non_fs_attr);
+
+	EXPECT_EQ(0, test_rename(file1_s1d1, file1_s1d2));
+	EXPECT_EQ(0, test_rename(file1_s1d2, file1_s1d1));
+	EXPECT_EQ(0, test_exchange(file2_s1d1, file2_s1d2));
+	EXPECT_EQ(0, test_exchange(file2_s1d2, file2_s1d1));
+}
+
+static const struct landlock_ruleset_attr net_attr = {
+	.handled_access_net = LANDLOCK_ACCESS_NET_BIND_TCP,
+};
+
+static const struct landlock_ruleset_attr scoped_attr = {
+	.scoped = LANDLOCK_SCOPE_SIGNAL,
+};
+
+TEST_F_FORK(layout1, layering_fs_then_net_does_not_break_refer)
+{
+	test_layering_does_not_break_refer(_metadata, &net_attr, false);
+}
+
+TEST_F_FORK(layout1, layering_net_then_fs_does_not_break_refer)
+{
+	test_layering_does_not_break_refer(_metadata, &net_attr, true);
+}
+
+TEST_F_FORK(layout1, layering_fs_then_scoped_does_not_break_refer)
+{
+	test_layering_does_not_break_refer(_metadata, &scoped_attr, false);
+}
+
+TEST_F_FORK(layout1, layering_scoped_then_fs_does_not_break_refer)
+{
+	test_layering_does_not_break_refer(_metadata, &scoped_attr, true);
+}
+
 /*
  * Tests walking through a denied root mount.
  */

-- 
2.56.1

