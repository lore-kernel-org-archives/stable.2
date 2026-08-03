Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7567416852;
	Mon,  3 Aug 2026 14:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785768367; cv=none; b=KjXcRoqJFoUWvcSNXDugyOBlWio9bzDu/dYBiRsHJe8AyyIk9ubK6g0usu6H1bbQT98ew5n2A3d7WHfq87WtSf3nwxQFLBvqWPwlMya50UN/Fe5KGFyadWSYN7K/OIUcTMamIlBpxjlC4S4s9H/ifE6mjLeZLLYqXhwBsvpEpFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785768367; c=relaxed/simple;
	bh=X7PUFf51jq9YwJqLruZyMfGrRDnFxYEF1Up2HYXFI8Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HFHhbfJNJ8AB3FvhRclFUsJFUJR1J6dDU8PM1noawYodRzQPfman+2+tFNQEeFIDKZTnVbPKsGY18xcKizKJ48MoJH3fjBrv46sEljS42huwWJjV0IH/cnfrb7+DLUBsF1DF4L+5FUZOPzbL+KACxW0NsTmmZE+DhMrV/LUrSCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn; spf=pass smtp.mailfrom=stu.xidian.edu.cn; dkim=fail (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b=ieXAluoF reason="key not found in DNS"; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b="ieXAluoF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=9u1ZX7DoEX
	iFdpyPwL7ZYYK6ksDIUUh9av5/Gp5cRVA=; b=ieXAluoFxiq5xXpqZEL7u8nKDL
	FlFUwTEff/AIMhbPSEJ+NWBKUt6arONYRSEYeUvWbDOcne5C5MhNC92BSVlUcGAf
	EGYeWlNipAz64vIWdgWvahFNkBU9xz+mn1dmW2n27pP2DHxETK9UDsiAsTKjODju
	HXl9VGzU+ouCfwJ8Q=
Received: from wmy.localdomain (unknown [221.14.152.201])
	by hzbj-edu-front-2.icoremail.net (Coremail) with SMTP id BLQMCkCW3DGlqXBquGbTAQ--.12834S2;
	Mon, 03 Aug 2026 22:46:01 +0800 (CST)
From: Mingyu Wang <25181214217@stu.xidian.edu.cn>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	stable@vger.kernel.org,
	Mingyu Wang <25181214217@stu.xidian.edu.cn>
Subject: [PATCH v3] tty: vt: fix memory leak in vc_allocate()
Date: Mon,  3 Aug 2026 22:45:56 +0800
Message-Id: <20260803144556.163856-1-25181214217@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:BLQMCkCW3DGlqXBquGbTAQ--.12834S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tr1kWF4fAF1UXFy5Zw17GFg_yoW8KryDpr
	n8Kr42yas8K3WSyFnrAa18XFyruay5KFy5GrWj934FvwsxXr10kF1rta45Wry8Xrs7Caya
	qrWUAwnIgF1qvaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9014x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
	FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr
	0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8v
	x2IErcIFxwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JUfnY7UUUUU=
X-CM-SenderInfo: qsvrmiqsrujiux6v33wo0lvxldqovvfxof0/1tbiAgUOEWpvXvycUAABsy

If the screen buffer allocation fails in vc_allocate(), the error handling
path jumps to `err_free`. However, this path fails to release the unicode
screen map attached to `vc->uni_pagedict_loc`.

During the early stages of vc_allocate(), the unicode screen map is either
newly allocated via con_set_default_unimap() or shares the default unicode
map from a previously initialized console (which increments its refcount).
If the subsequent kzalloc() for the screen buffer fails, the err_free path
frees the vc structure but leaves the attached uni_pagedict with an
elevated refcount. This results in an unreferenced object memory leak, as
the reference to the dictionary is lost and its refcount can never reach
zero.

This issue was discovered by DevGen (an automated virtual device modeling
fuzzer based on Syzkaller). During fuzzing with kernel fault injection
(failslab) enabled, the fuzzer forcefully failed the kzalloc() for the
screen buffer, exposing this error-handling path leak.

Fix this by checking *vc->uni_pagedict_loc and calling con_free_unimap(vc)
in the err_free path before kfree(vc). This safely decrements the refcount
and releases the dictionary memory if this was the last reference. The
explicit check is added to maintain consistency with other callers.

Fixes: 34902b7f2754 ("tty: vt, get rid of weird source code flow")
Cc: stable@vger.kernel.org
Signed-off-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>
---
Changes in v3:
- Added an explicit check for *vc->uni_pagedict_loc before calling
  con_free_unimap(vc) to maintain consistency with other callers, as
  suggested by Greg KH.

Changes in v2:
- Added documentation in the commit message detailing the fuzzing
  environment (DevGen/Syzkaller) and the fault injection (failslab)
  mechanism used to discover the bug.

 drivers/tty/vt/vt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 8f467b22b799..fdb5c10258a8 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1134,6 +1134,8 @@ int vc_allocate(unsigned int currcons)	/* return 0 on success */
 	return 0;
 err_free:
 	visual_deinit(vc);
+	if (*vc->uni_pagedict_loc)
+		con_free_unimap(vc);
 	kfree(vc);
 	vc_cons[currcons].d = NULL;
 	return err;
-- 
2.34.1

