Received: from zg8tndyumtaxlji0oc4xnzya.icoremail.net (zg8tndyumtaxlji0oc4xnzya.icoremail.net [46.101.248.176])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA5D484248;
	Wed, 23 Sep 2026 10:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.101.248.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790159102; cv=none; b=ocZb4lKvk7s02a1uPGgkY6RGSwIisEe6X3E+g09Mm57Gx7CJVUFS5ElzwiOVuq7M7VsIuv44UQ2r6vfNJbCAdKUBRvM41CKJGKOuxVzyvIiR/lVSUqtWQdz8h9cw7j2mgqfkEHDnzmGhavTVdGT/NnJkbNiCfJqLrEXgdCfaDR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790159102; c=relaxed/simple;
	bh=OyAgyATgC2kWYkMsDFvv3ITJUycleepuX8/YiQMvrpw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=lFOZoyJsmZIWcrgV+8nidlb9DUtMYBpYOlmlZPuWG0pKRlVXaOOPuDpSW8pCs0BMOmZqjRWrr+LjfPCpRQuoLV1w74qsGfoRLgGibjskUeMFwV54VYLh5Sg7KjrloMueCdwxwwf4LMTfJD2qMcN69XbY8ny7NE8TfZbaUdf0wJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=46.101.248.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.190.132.220])
	by mtasvr (Coremail) with SMTP id _____wAnAX7lqLNqQmUxAQ--.7460S3;
	Wed, 23 Sep 2026 18:24:38 +0800 (CST)
Received: from smtpclient.apple (unknown [10.190.132.220])
	by mail-app4 (Coremail) with SMTP id zi_KCgAX_DTjqLNqrOjOAw--.715S2;
	Wed, 23 Sep 2026 18:24:35 +0800 (CST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH] gpio: mpsse: fix race when arming the IRQ poll worker
From: Fan Wu <fanwu01@zju.edu.cn>
In-Reply-To: <CAMRc=MfHeDs5FndscwsM1Ycogq9Z8gqp4=XjY4__g_2yKTqNYg@mail.gmail.com>
Date: Wed, 23 Sep 2026 18:24:24 +0800
Cc: linux-gpio@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org,
 Song Li <songl@zju.edu.cn>,
 Linus Walleij <linusw@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C51EFFE2-91C4-44C1-AF4C-16A71418DDFE@zju.edu.cn>
References: <20260923030855.410109-1-fanwu01@zju.edu.cn>
 <CAMRc=MfHeDs5FndscwsM1Ycogq9Z8gqp4=XjY4__g_2yKTqNYg@mail.gmail.com>
To: Bartosz Golaszewski <brgl@kernel.org>
X-Mailer: Apple Mail (2.3774.600.62)
X-CM-TRANSID:zi_KCgAX_DTjqLNqrOjOAw--.715S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?vNLpNAXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfnXz+g1OQfMo27QHy5TwQyZyr8bqxAZIr9Li14pk8vl4LYMWhw4Esn2XHJWyH8KeYgER+
	z3cYG6OUfT0Try0gjxs=
X-Coremail-Antispam: 1Uk129KBj9xXoWrZFy8KryDCF17WF4xtF43Arc_yoWDXFbE93
	s8ta9Ika48ZFsrZasxKF48tr1kKFy0kFyftry8GFWxJ3s7ArZ5JFZxua1FvFn3J3s7Xr48
	AryfW3yDWw1jvosvyTuYvTs0mTUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbTxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6x
	kI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v2
	6r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2
	Ij64vIr41lF7xvr2IYc2Ij64vIr40E4x8a64kEw24l42xK82IYc2Ij64vIr41l4I8I3I0E
	4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGV
	WUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_
	Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rV
	WUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWx
	JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8Tv3UUUUUU==


> On Sep 23, 2026, at 16:15, Bartosz Golaszewski <brgl@kernel.org> =
wrote:
>=20
> I probably wouldn't have noticed but Sashiko found an issue on =
PREEMPT_RT
> kernels[1].
>=20
> Bart
>=20
> [1] =
https://sashiko.dev/#/patchset/20260923030855.410109-1-fanwu01%40zju.edu.c=
n?part=3D1

Hi Bart,

You're right, thank you for catching this.

The new kfree() is called while holding priv->irq_spin. More =
importantly,
moving it just after that scoped guard would not be sufficient: =
irq_enable()
is invoked with the IRQ descriptor raw spinlock held by the IRQ core.

Thus, a normal kfree() cannot be used on this path on PREEMPT_RT. The
worker must instead be disposed of from a safe context, while keeping =
its
list publication and schedule_work() together under irq_spin so that the
disconnect race is not reintroduced.

I will rework the cleanup path accordingly and also recheck the =
pre-existing
GFP_NOWAIT allocation in this irqchip callback for PREEMPT_RT =
constraints.

Thanks,
Fan=

