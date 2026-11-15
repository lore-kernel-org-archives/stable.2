Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794717340;
	b=C7Kq/w91IAC5moF1d3/ZEV+kY/YqJrgVV4BAN0XGuJkZGOo0cceWft0lVS5grUOVoG4o
	 vWJJfTWaLpqGN/TFvv8mKc67OzSTNOtz9F0ScLXcasUkcD3BzoFU+6BUxnn+7H1VvOiLB
	 SSdQIIsNeLDfxOhPWmVZ6bzezS8sJZPZbnADots1LBE2Zs+aQP16koRxT9WOHH5MOqr7C
	 +ZVh1H2UHeGQC9K9WcxSaEFJGupr9utNRR6Evi1xQ7344nh7nyYjx4xorHRhsOMjf+M1e
	 OcidUz/INUxzyn96S+0eGKOEb5Ti8Efmer5Kn3HfKx2KFPsM8aI9UHR01myVPXo3CfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794717340;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=pge8S+uzPBjYzO9sQ/3/s+m2MnX1W31RL27i5NJe3sM=;
	b=xuF/DTbsPrGx9WMcKPdJHIrxCVupq0CV1hvphJmM1CnJYxpZIFBwvg7wGpoWVolJsHEh
	 HFnie/fwFRYz8OiLmXCygkXcIUXJUuBgOA+oqIi63DVAclFwWgMqcGZVjIERpIWHdGcSy
	 5hLcTI/n0zyo46tc3PNybRCsKhTvxujha3fYFtNVcBtrM/sKNvjf/brYa0P97rjA0zU9b
	 mbmOWOv0RY2L9PJoaKDIoePB3wEKoM78/j7yAqrYDSPhWkjiC2jWxcJlLKYP1ESx4EP9w
	 cj1yURV1KuGFTaa3SUrlrJG1XXZbEOLSYr7ZNyi8xiJTmNDWB1cwclR+CrfrOuNG2hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TtiHk++8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DC6606A323;
	Sun, 15 Nov 2026 04:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TtiHk++8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4589B1F000C4;
	Sun, 15 Nov 2026 04:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794717339;
	bh=pge8S+uzPBjYzO9sQ/3/s+m2MnX1W31RL27i5NJe3sM=;
	h=From:Date:Subject:To:Cc;
	b=TtiHk++8tQHafjcGYp/xGrHpiXXoT8vhlQVhEZ24RMB0GOQcBnhKKzpeWZEduoLew
	 Wq5Azc/0MBnlmG3bSxy4lnfjDHVtwK4ZoK67gTNvPQvrBM9THocGbhiSudonVB4L53
	 8ksUFWN8vGpd3JOzX4PVyo6lu8lcXtS2rOcuZ2aBYAT2FesiG3axRIwJor13PROdoo
	 VEUFtWoJYHhFiyny7SFc4Qx802tSL4f90aGalRboqS0aafTW9s/AuJbgBvJwLRtav+
	 N0Tfgm//J3rDcozU/bdq14GzFNFFAx/ofWJGcbnvUgYNUxnkM/ucUheQVz44pJ9qe1
	 /jws/+E8U40uw==
From: Nathan Chancellor <nathan@kernel.org>
Date: Sat, 14 Nov 2026 21:35:33 -0700
Subject: [PATCH] lkdtm/bugs: Remove volatile from element_count
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261114-lkdtm-bugs-wunsequenced-v1-1-b24f15ce1328@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/yXMwQ6CMAyA4VchPduELsSJr2I8SFexqFNXpiaEd
 3fC8Tv8/wQmScVgX02Q5K2mj1hAmwr4coq9oIZicLXbElGDt2sY79jl3vCTo8krS2QJ6Jl2Tdu
 y856g1M8kZ/0u58NxteVuEB7/O5jnHzaJdJt7AAAA
X-Change-ID: 20261114-lkdtm-bugs-wunsequenced-7c18499c2771
To: Kees Cook <kees@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, stable@vger.kernel.org, 
 kernel test robot <lkp@intel.com>, Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2596; i=nathan@kernel.org;
 h=from:subject:message-id; bh=PXq6yOI2haGDOFCWB2rN+EDzgPLHZ2hY9ZGbOCcl0rs=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDFk/zaYXeDZXMzGc05ffviN0l/Kq7W0GwdPNdzQu/9Wwc
 PLnU6HBHaUsDGJcDLJiiizVj1WPGxrOOct449QkmDmsTCBDGLg4BWAiESEM/wyPzQyX6HvhasrI
 8qa9zncJn6K8AKNuxtke8Z73iyqXP2H4H2xm5iBn0efxr8ZukcEht5tad7fd+HTqu5lRI8OEmUe
 X8gEA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

After a recent improvement in clang to warn on unsequenced accesses to
volatile variables [1], an instance appears in lkdtm_FAM_BOUNDS(), which
can break the build with CONFIG_WERROR=y / W=e:

  drivers/misc/lkdtm/bugs.c:493:31: error: unsequenced accesses to volatile qualified 'element_count' [-Werror,-Wunsequenced]
    493 |         inst->array[element_count] = element_count;
        |                     ~~~~~~~~~~~~~    ^

Per C11 5.1.2.3.2, accessing a volatile object is a side effect. Per C11
6.5.2, unsequenced side effects on the same scalar object are undefined
behavior. Per C11 6.5.16.3, the value computations of the left and
right operands of the assignment operator are unsequenced.

This variable is marked volatile to hide its value from the compiler at
compile time. The same thing can be accomplished with
OPTIMIZER_HIDE_VAR. Drop volatile from element_count to clear up the
warning. The tests still pass and there are no warnings at compile time.

Cc: stable@vger.kernel.org
Fixes: 5d207e83ca41 ("lkdtm: Add FAM_BOUNDS test for __counted_by")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202611140405.wMowxoPE-lkp@intel.com/
Closes: https://github.com/ClangBuiltLinux/linux/issues/2194
Link: https://github.com/llvm/llvm-project/commit/955715460eaf9188c241c74750637fc82dfcc423 [1]
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/misc/lkdtm/bugs.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/lkdtm/bugs.c b/drivers/misc/lkdtm/bugs.c
index 2761685cf4f8..7c799fef89a8 100644
--- a/drivers/misc/lkdtm/bugs.c
+++ b/drivers/misc/lkdtm/bugs.c
@@ -472,12 +472,14 @@ struct lkdtm_cb_fam {
 	int array[] __counted_by(count);
 };
 
-static volatile int element_count = 4;
+static int element_count = 4;
 
 static void lkdtm_FAM_BOUNDS(void)
 {
 	struct lkdtm_cb_fam *inst;
 
+	OPTIMIZER_HIDE_VAR(element_count);
+
 	inst = kzalloc_flex(*inst, array, element_count + 1);
 	if (!inst) {
 		pr_err("FAIL: could not allocate test struct!\n");
@@ -534,6 +536,8 @@ static void lkdtm_PTR_BOUNDS(void)
 {
 	struct lkdtm_cb_ptr *inst;
 
+	OPTIMIZER_HIDE_VAR(element_count);
+
 	inst = kzalloc_obj(*inst);
 	if (!inst) {
 		pr_err("FAIL: could not allocate struct lkdtm_cb_ptr!\n");

---
base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
base-tree: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
change-id: 20261114-lkdtm-bugs-wunsequenced-7c18499c2771

Best regards,
--  
Cheers,
Nathan

