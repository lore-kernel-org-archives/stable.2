Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794335958;
	b=U/EDWvQfWdo01kxLuVDwQCWIme9RfXBcmDd5UVzmmugtzAolOhGzKBrJ6l9f5PUXRXYF
	 jMyf432kZoJRLeuh84hzqYYGEOkyqB6Pi/TRm5n3rvI1hMz/PniKRYSW9R7L+1q+PScpI
	 Gi6yJvis64cixRYNw52zZNdGtEu5b6RFRs3rhTYoALpKNyKYVQ+yDQTFhblsbwN7YZ23G
	 ej3YAD3VeutIi0XA8ptP+5x65azlM0/5tCDeDpKWVBnfPTnKvLSA/Z9nmYeDIa67pRKQW
	 DPfDmQJCoZIBC25WjfhiwRojZmBABX4U9jBEMJjKvDokxCScJUhIby2wpEjKrHUczfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794335958;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=/9aKLLubzj1KJTeLHfXi6B4hy1LCtTqTLbqCOThS76I=;
	b=bQSiarP6EO3PhdnH9zS3CMbzJsk0JfZ8v1oR8qtixmFFjD4QgewogyV6PjWheWEWhoqE
	 NBzkIeQcK4CzvqPjGCN37I0r5ytShXGeDSUVyV+C/j5oM8ki5fmXs9vPrXPi2kRBNOGL5
	 4N5RJKMgmRVWNvQkJQ5uWK2whOjewOAxpMObbz1fe9aIjwsk4pR+wdcRUNVuF5bhH/1gp
	 wV0pyO9aNHbEOxEm0PAK6Fvh4zpyf17kSJiNGwbK+MJF7pgkrQiY+9WWSCNkT9q75q7ml
	 RYcvr7lGt1TuxvV2rybjg9d9yFguFoJHGCKgSszMsK5v2gviRJLk+z0QsIDcHPnOQ4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UvBJqG2x;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F7D606A33E
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 18:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UvBJqG2x
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F1231F0089F;
	Tue, 10 Nov 2026 18:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794335957;
	bh=/9aKLLubzj1KJTeLHfXi6B4hy1LCtTqTLbqCOThS76I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UvBJqG2xRek+sa6TM+Wuh/u+XLwjRKV1RX1Skgzj91gMx/Y8Du1sXLdKs74gfz3oO
	 Y0VTknyWWuz9BTOSlQVdMFq+EfnDJ91sty0X6Sx4/s9BdpzsSyn4VrYl/jl7OyA5dU
	 G/avDgB3JKuwUzPVr9st67J5UXlhsHIjdOuohjc9i0ViaZDNusbaX4IsR2ESV6Yv+Y
	 O+DwHnEsLwY7IUlfGUDBoq8rm6XviHcAJviA3QEl3j+vZI4kRw1KQhyBCVxm3VdgVr
	 HdECkK9J1s36X19CGxGDFC83G7mbBB6bzXuPQzEb81Th3zM6doroJCkXiU9GrC7wVs
	 QS4GiZwLg2Beg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jinchao Wang <wangjinchao600@gmail.com>,
	Anna Schumaker <anna.schumaker@oracle.com>,
	Baoquan He <bhe@redhat.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Dave Young <dyoung@redhat.com>,
	Doug Anderson <dianders@chromium.org>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Helge Deller <deller@gmx.de>,
	Ingo Molnar <mingo@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Joanthan Cameron <Jonathan.Cameron@huawei.com>,
	Joel Granados <joel.granados@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	Kees Cook <kees@kernel.org>,
	Li Huafei <lihuafei1@huawei.com>,
	"Luck, Tony" <tony.luck@intel.com>,
	Luo Gengkun <luogengkun@huaweicloud.com>,
	Max Kellermann <max.kellermann@ionos.com>,
	Nam Cao <namcao@linutronix.de>,
	oushixiong <oushixiong@kylinos.cn>,
	Petr Mladek <pmladek@suse.com>,
	Qianqiang Liu <qianqiang.liu@163.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Sohil Mehta <sohil.mehta@intel.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Tejun Heo <tj@kernel.org>,
	Thomas Gleinxer <tglx@linutronix.de>,
	Thomas Zimemrmann <tzimmermann@suse.de>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Ville Syrjala <ville.syrjala@linux.intel.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Yunhui Cui <cuiyunhui@bytedance.com>,
	"Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] panic: use panic_try_start() in nmi_panic()
Date: Tue, 10 Nov 2026 13:39:10 -0500
Message-ID: <20261110183723.3255298-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052209-failed-6.12-75eb687ff2bc@kernel.org>
References: <20261107052209-failed-6.12-75eb687ff2bc@kernel.org>
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

From: Jinchao Wang <wangjinchao600@gmail.com>

[ Upstream commit 6b69c7ef96f1afc7b426195087f7488f1510c2a4 ]

nmi_panic() duplicated the logic to claim panic_cpu with
atomic_try_cmpxchg.  This is already wrapped in panic_try_start().

Replace the open-coded logic with panic_try_start(), and use
panic_on_other_cpu() for the fallback path.

This removes duplication and keeps panic handling code consistent.

Link: https://lkml.kernel.org/r/20250825022947.1596226-5-wangjinchao600@gmail.com
Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
Cc: Anna Schumaker <anna.schumaker@oracle.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>
Cc: Dave Young <dyoung@redhat.com>
Cc: Doug Anderson <dianders@chromium.org>
Cc: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: Helge Deller <deller@gmx.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Joanthan Cameron <Jonathan.Cameron@huawei.com>
Cc: Joel Granados <joel.granados@kernel.org>
Cc: John Ogness <john.ogness@linutronix.de>
Cc: Kees Cook <kees@kernel.org>
Cc: Li Huafei <lihuafei1@huawei.com>
Cc: "Luck, Tony" <tony.luck@intel.com>
Cc: Luo Gengkun <luogengkun@huaweicloud.com>
Cc: Max Kellermann <max.kellermann@ionos.com>
Cc: Nam Cao <namcao@linutronix.de>
Cc: oushixiong <oushixiong@kylinos.cn>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Qianqiang Liu <qianqiang.liu@163.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Sohil Mehta <sohil.mehta@intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Thomas Gleinxer <tglx@linutronix.de>
Cc: Thomas Zimemrmann <tzimmermann@suse.de>
Cc: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Ville Syrjala <ville.syrjala@linux.intel.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Yicong Yang <yangyicong@hisilicon.com>
Cc: Yunhui Cui <cuiyunhui@bytedance.com>
Cc: Yury Norov (NVIDIA) <yury.norov@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 75eb687ff2bc ("panic: flatten nmi_panic control flow")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/panic.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/kernel/panic.c b/kernel/panic.c
index 97c472164393b..b4db7f62b8ed5 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -248,15 +248,9 @@ EXPORT_SYMBOL(panic_on_other_cpu);
  */
 void nmi_panic(struct pt_regs *regs, const char *msg)
 {
-	int old_cpu, this_cpu;
-
-	old_cpu = PANIC_CPU_INVALID;
-	this_cpu = raw_smp_processor_id();
-
-	/* atomic_try_cmpxchg updates old_cpu on failure */
-	if (atomic_try_cmpxchg(&panic_cpu, &old_cpu, this_cpu))
+	if (panic_try_start())
 		panic("%s", msg);
-	else if (old_cpu != this_cpu)
+	else if (panic_on_other_cpu())
 		nmi_panic_self_stop(regs);
 }
 EXPORT_SYMBOL(nmi_panic);
-- 
2.53.0

