Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E701133B6D9;
	Fri, 31 Jul 2026 02:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785465974; cv=none; b=QsX+dUWLydhBazpMG2JpWG01BGpwiJnyySxYTw3WFsNdMxAX5eC1f29YAoS0UQHU/rMZmd51QAoR8obfNxJJ/74oUdYA+vtRaycj5iXeEuvCR9dmCZQ49OpUHIJ0+MDAWpF8jy0ayPy58GD7ZbIwRW5bTtPMzSLbKwq+xo668pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785465974; c=relaxed/simple;
	bh=mUS4G2ULN5kZHTwipcf1t+xtKRof5AF6yhDhrxYudhg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lBD/uzYoEH/GIhgijYVE2xq+JIucGzuaXFWNEWphdiOSPGxzJMT6ZFvSpda2W/ejqM0Nd+UzS4NL7NIXZN13M0IegQNOdkpA4Lu/MJ56OJ31Phu/JxricYZ7NZICgnrxtKUXFdGzWA0OjnbB1GZUrt8OY2py7LAt+S83ogQy8Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn; spf=pass smtp.mailfrom=stu.xidian.edu.cn; dkim=fail (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b=4q1gnOsj reason="key not found in DNS"; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b="4q1gnOsj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=aW+SWeZI97
	LW4jbwATlCbid8ooslJnXbTxJlFk4icD4=; b=4q1gnOsjudJd36kI688xB8Aj7K
	0iCMsYXQhCbYk87D7p3K9nl1EKMFxrxBFB2nlw717M9OiXy5IGXuIRiR1+8veJmN
	oHYzP+zxQ73TMrrVWRyhLAoJykf+y7BYDrN33hj4BXkYVcJgLYZpur7JFe0FX8dO
	1DL9+W0DQlQJtN0GM=
Received: from wmy.localdomain (unknown [221.14.152.201])
	by hzbj-edu-front-4.icoremail.net (Coremail) with SMTP id BrQMCkC23RNiDGxq7fisAQ--.17105S2;
	Fri, 31 Jul 2026 10:45:58 +0800 (CST)
From: Mingyu Wang <25181214217@stu.xidian.edu.cn>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	stable@vger.kernel.org,
	Mingyu Wang <25181214217@stu.xidian.edu.cn>
Subject: [PATCH v2] tty: vt: fix memory leak in vc_allocate()
Date: Fri, 31 Jul 2026 10:45:50 +0800
Message-Id: <20260731024550.158801-1-25181214217@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:BrQMCkC23RNiDGxq7fisAQ--.17105S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tr1kWF4fAF1UXFy5Zw17GFg_yoW8Zw1Upr
	s8KrW2yF90g3WIyFnrAw48XFyrWa13KFy5CFWjg340vwsxXFyvkF1Fya45WryUZr4kC3W3
	trWqk3s0gF1qvaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvK14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j
	6r4UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8JV
	W8Jr1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
	648v4I1lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
	v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
	1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
	AIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
	42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxh
	VjvjDU0xZFpf9x0JUfnY7UUUUU=
X-CM-SenderInfo: qsvrmiqsrujiux6v33wo0lvxldqovvfxof0/1tbiAgULEWpranxD4AAAsp

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

Fix this by calling con_free_unimap(vc) in the err_free path before
kfree(vc). This safely decrements the refcount and releases the dictionary
memory if this was the last reference.

Fixes: 34902b7f2754 ("tty: vt, get rid of weird source code flow")
Cc: stable@vger.kernel.org
Signed-off-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>
---
Changes in v2:
- Added documentation in the commit message detailing the fuzzing
  environment (DevGen/Syzkaller) and the fault injection (failslab)
  mechanism used to discover the bug, as requested by Greg KH.

 drivers/tty/vt/vt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 8f467b22b799..4bac89ea968a 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1134,6 +1134,7 @@ int vc_allocate(unsigned int currcons)	/* return 0 on success */
 	return 0;
 err_free:
 	visual_deinit(vc);
+	con_free_unimap(vc);
 	kfree(vc);
 	vc_cons[currcons].d = NULL;
 	return err;
-- 
2.34.1

