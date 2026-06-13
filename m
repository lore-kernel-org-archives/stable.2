Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.76.78.106])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169BF136351;
	Sat, 13 Jun 2026 12:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.76.78.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781354925; cv=none; b=UAemdd1n8PR6TB9A1RSWxFEabq22sNDArjKUdkXFxKl6a7PbfeQcho/X2QwunKtvDJE1apLTggCE25q5Y8ZlNnejefIDGEsCKSNkEmqF2a011XLuP1yvcqEnsHvHm1aWCEYX0fgn0dNjgakSZBgkdDUki8i80KG+WT+Q+uCQUBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781354925; c=relaxed/simple;
	bh=U0WyzZ17yXkey+M4HF+ZBSIWRHabhAxTSQcnOAD8gDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ODowa4Vs59pw0ZfW1fMdU+NrJ+3j+eaXAv0Ui50kC4TBkh+qJfM5q8nKjR0Co61ySeeKWEgkjWfWt6e1hPA42lrvAytnWA8lMyuPMhFgSO3nT7zCHngFee0uwxgMI41mayMD5Uqf73fDWZXrPcd3alWTnFRh+8EMjaanc8pvmMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=SqOgOxVI; arc=none smtp.client-ip=13.76.78.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="SqOgOxVI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	Content-Transfer-Encoding; bh=mo1J0807K/uGm7dxm5vkx+ugAfm+jhFxnJ
	vZdSbv/0w=; b=SqOgOxVIqV8sHRam1EydO5OGxAESIKIIQp0hbH4dr6ATAy7cJ9
	PouYiEtP0wSrWm9inkhtwSJxPTOq/yHMXxpSQRkPwHwLi0csefdbab3pjf9+/GSh
	Q8j6JrA7lG+Ou6LbKINFXUbgItSeRY0ARJYXGxU6FQf8k0nrfUqBKRbtk=
Received: from localhost.localdomain (unknown [101.5.13.242])
	by web4 (Coremail) with SMTP id ywQGZQD3CJ6eUS1qfMU+Ag--.36758S2;
	Sat, 13 Jun 2026 20:48:30 +0800 (CST)
From: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
To: xiaowu.417@qq.com
Cc: asmadeus@codewreck.org,
	ericvh@kernel.org,
	fengxw06@126.com,
	linux-kernel@vger.kernel.org,
	linux_oss@crudebyte.com,
	lucho@ionkov.net,
	qli01@tsinghua.edu.cn,
	stable@vger.kernel.org,
	v9fs@lists.linux.dev,
	wangao@seu.edu.cn,
	xuke@tsinghua.edu.cn,
	yangyx22@mails.tsinghua.edu.cn,
	zhaoyz24@mails.tsinghua.edu.cn
Subject: Re: [PATCH] net/9p/usbg: Fix use-after-free in disable_usb9pfs()
Date: Sat, 13 Jun 2026 20:48:24 +0800
Message-ID: <20260613124831.7674-1-zhaoyz24@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <tencent_CC4B1079E0461B8950A0CA98790792059109@qq.com>
References: <tencent_CC4B1079E0461B8950A0CA98790792059109@qq.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ywQGZQD3CJ6eUS1qfMU+Ag--.36758S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr1fWw4Uur1fGr4ruFW8Crg_yoW8CF1xpa
	yIgw1FyFWDtFy2kF4qy34UJay0ya18CrWUKF45Wr1Yy345Wr9Y9F18Kws5ua1qvFn3Cr10
	yr1qq3yDCrsrAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9m1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l
	84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcx
	kEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6x8ErcxFaVAv8VW8
	Ww4UJr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6I
	AqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xS
	Y4AK67AK6ryUMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_GrWkJr1UJwCFx2
	IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
	6r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
	AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
	s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
	0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0Jj4a0QUUUUU=
X-CM-SenderInfo: 52kd05r2suqzpdlo2hxwvl0wxkxdhvlgxou0/1tbiAQMRAWoshq+0-AAAs1

Hi Xiao,

Thanks for the PoC. I re-tested it on a fresh upstream tree
(2d3090a8aeb5, 7.1.0-rc7-00016-g2d3090a8aeb5) with KASAN and lockdep
enabled, and I can reproduce the reported call trace:

  strcmp
  look_up_lock_class
  register_lock_class
  __lock_acquire
  lock_acquire
  __wake_up
  p9_client_cb
  usb9pfs_clear_tx

Without lockdep, the same PoC reaches the same usb9pfs_clear_tx() ->
p9_client_cb() -> __wake_up() path, but it shows up as an RCU stall
instead of the lockdep/strcmp crash.

On Sat, Jun 13, 2026 at 04:27:38AM +0800, XIAO WU wrote:
> I wrote the following PoC to trigger this bug.  It creates a USB
> gadget with a usb9pfs function, sets buflen=0 so that alloc_ep_req()
> fails in alloc_requests(), which frees in_req without NULLing the
> pointer, then unbinds the gadget to trigger usb9pfs_clear_tx() on the
> dangling in_req.

However, I think the actual trigger is slightly different from the
allocation-failure path described in the mail. Setting buflen to 0 does
not make alloc_ep_req() fail in my test: usb_ep_align(..., 0) produces a
zero length, and kmalloc(0) returns ZERO_SIZE_PTR rather than NULL. So
alloc_requests() still succeeds.

The failure seems to happen because in_req->context is still initialized
as the f_usb9pfs pointer. During disconnect, usb9pfs_clear_tx() treats
that context as a struct p9_req_t * and passes it to p9_client_cb(),
which eventually calls wake_up() on a bogus req->wq. With lockdep
enabled, that bogus waitqueue/lock state leads to the strcmp ->
register_lock_class() crash.

So I agree that the PoC exposes a real usb9pfs teardown/context bug, but
it looks independent from the endpoint-disable/free-ordering UAF fixed by
my patch. I think it would be clearer to handle it in a separate patch, 
with a commit message describing the actual trigger path.

Thanks,
Yizhou

