Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794815332;
	b=3cB6kHgjjsVyxnQbXKh48zJe4fPzHeR0+gWjBgK48vgxBu1oqYU9maKBXj3evHGgwWkc
	 /3powy+Bx8Xpbb8nokWd99DqxdAo6yZys+Yw6Ey7TuulehJfD3bNjq6cZKAzzCPcK3+Ne
	 GTSQi2h5qOvVbbIdEV+RbrRunFzr60BSYzQwuXbYhTy9KQWzLzfSXqw3s2s7NOoDcKw2j
	 Kfie2AoFpwUFFFVE7EIqrMuJRzF3hcdnVk6lluht0DjxkVk2ARkLC45qCPbZ01GrUiU+U
	 8C52bJPnP+SHlfAGu9o5KPD4K0jphVM3aoahRNcPs3CXm1UQipwQ0Q+AOLwneqwyDwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794815332;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=7ONel+q3Mnw6zurSffITBewVegTFoBV2JIAW3Uihbds=;
	b=bwTenCC0SlJh6yjPJgWkS6v06sCryEzwxP1pL53M+Nbn4h7hBm+xX+PCn0i8jjfDLNhl
	 jisO5Ct2sGAoSsc8HVNzq0QUQPi07AEph3zPHjgFHatcWNS9g7HK0urYWqP/IE4Un5nTH
	 rXCa+VW2ATDft1e6Pg6sQg8/pmyUtqWRQ5fcSMlCPNFL7Q7s/QrOwTnuarMipwm8HUMGG
	 t4imJwn8A+IY6aTUotRWeQ4yi6sAfzjgIEwktFUw+UDd29zMWJ4EqOfRd0lo9UoPL1WK9
	 bdp0dzfrO4NE30Gj/iX18zKQgf3ORXwpz1PmPJH8UJPiMnyYjjqUcAVfq/fFlj+LGGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18440606A31C;
	Mon, 16 Nov 2026 07:48:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18440606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=7ONel+q3Mn
	w6zurSffITBewVegTFoBV2JIAW3Uihbds=; b=jHKoWmQLTf5nGWisNY9Lawum/q
	ghKprY9UYwO7J724oxV3s2+FaZN1kT2SZ1iN014gvHUHRKGc+qxceusOnB+92fqB
	7FhkHsuR85JLiWiX3q3IXuEHi5OnM0Uat9Hx2V0+wLdEb4ldR63sDeCZ0se/dYVy
	UNGmFmdYiDOYPzr+Y=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.41])
	by hzbj-edu-front-3.icoremail.net (Coremail) with UTF8SMTPA id BbQMCkDGyv1YtfpqpsC0AQ--.43329S2;
	Mon, 16 Nov 2026 15:48:41 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Dave Penkler <dpenkler@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>
Subject: [PATCH] gpib: fix NULL pointer dereference in autospoll_ioctl()
Date: Mon, 16 Nov 2026 15:48:39 +0800
Message-Id: <20261116074839.3393-1-25031212351@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
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
X-CM-TRANSID:BbQMCkDGyv1YtfpqpsC0AQ--.43329S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uF13CF45uF4kWF45AF4UCFg_yoW5JrWrpF
	W5G3yjkr95JrsFgF43G3WxWa15AanxCFW7uryjvw13uwsYvrWkur1a9a45CFZ5Ary8AF90
	yr1qva42gFW5Aw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvGb7Iv0xC_Cr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
	C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq
	07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r
	18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vI
	r41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
	0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
	17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
	C0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
	6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
	73UjIFyTuYvjxUcCJmUUUUU
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAgUTD2r5zUhtNAABsV

IBCLOSEDEV with handle 0 removes the board descriptor from
file_priv->descriptors and frees it.  autospoll_ioctl() is the only
handler that looks the board descriptor up without checking the result
of handle_to_descriptor(), so a following IBAUTOSPOLL dereferences the
NULL pointer in the autopoll_enabled bitfield:

  general protection fault, probably for non-canonical address
  0xdffffc0000000002: 0000 [#1] SMP KASAN
  KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
  RIP: autospoll_ioctl drivers/gpib/common/gpib_os.c:1667
  Call Trace:
   ibioctl
   __x64_sys_ioctl
   do_syscall_64
   entry_SYSCALL_64_after_hwframe

The lookup is also performed without file_priv->descriptors_mutex, so
even without the NULL case the descriptor can be freed by a concurrent
IBCLOSEDEV between the lookup and the access.

Take descriptors_mutex around the lookup and the use, as the other
handlers that use a descriptor do, and return -EINVAL when the board
descriptor has been closed.

Fixes: 9dde4559e939 ("staging: gpib: Add GPIB common core driver")
Cc: stable@vger.kernel.org
Co-developed-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Bin Yu <byu@xidian.edu.cn>
Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
---
 drivers/gpib/common/gpib_os.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpib/common/gpib_os.c b/drivers/gpib/common/gpib_os.c
index 384800e6bf97..f341c36ba475 100644
--- a/drivers/gpib/common/gpib_os.c
+++ b/drivers/gpib/common/gpib_os.c
@@ -1661,7 +1661,16 @@ static int autospoll_ioctl(struct gpib_board *board, struct gpib_file_private *f
 	if (retval)
 		return -EFAULT;
 
+	/*
+	 * IBCLOSEDEV removes the board descriptor from the table and frees
+	 * it, so the lookup and the use have to be under descriptors_mutex.
+	 */
+	mutex_lock(&file_priv->descriptors_mutex);
 	desc = handle_to_descriptor(file_priv, 0); /* board handle is 0 */
+	if (!desc) {
+		mutex_unlock(&file_priv->descriptors_mutex);
+		return -EINVAL;
+	}
 
 	if (enable) {
 		if (!desc->autopoll_enabled) {
@@ -1685,6 +1694,7 @@ static int autospoll_ioctl(struct gpib_board *board, struct gpib_file_private *f
 			retval = -EINVAL;
 		}
 	}
+	mutex_unlock(&file_priv->descriptors_mutex);
 	return retval;
 }
 
-- 
2.34.1

