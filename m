Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE443ACF1D;
	Tue,  1 Sep 2026 16:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788281416; cv=none; b=aft5ghFvBno/HScpYRtwgNUSs54V2TwltxMm+4c3QI7kXdgjzf2Ig9JT3Zrjv4RxOr4okxUmYVhgOQOTbnWzBS1iqamRSoatojgNDWH9m7X2aZbQ33X53OD7ZxkNDB3TuRMrN2WPy5BpRVlU8db70dOEzPdewUUjunXF1QGa4Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788281416; c=relaxed/simple;
	bh=qHIG3I/hqD2fBul2mjpru/HzPCUM9gwX5yOoU+XOHms=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hkQeVw2tuK+NH6bq/BAYSP+cLu3QSPo+qf1Wft9sbOttEJULZJtgaUAikLr1b971mOqBszN4VS/pLNccUWIgrBzDmKMq4GJsHcEWdsQp1IBjSRe80vX4dBO02OXhBW6Gjc779dog7FNRq72c/SJO/U1Thv8slYDTgxTmFbbYG2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZEKR8QbH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZEKR8QbH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39B961F000E9;
	Tue,  1 Sep 2026 16:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788281415;
	bh=LzDZEH2B663ndFhIh0uM4TIWenDVdFc5Pmko9MwU9xw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=ZEKR8QbHbUoP7Trtg8gKfksuiY4EsNfScwY2sOBHFuup7v2wNnJUHlrYRAwxzzO+r
	 aiFXG51wmiWyF5+HLLcbUiUcjMU18scjWwZeYb+DnIZRVZLrJBjhP3GMKrZFx3TQYQ
	 e8MfdfQ5XOHJVyCkGjgZ26aFig97IpNZSGt5HGfs+sPuTDZQX87vJcQYuorRAX+KSU
	 I1nYGPctYd1MZF4MDT0w82brXFo17ZSdOx9T2IgP5RGFXHz9TLEjR7xu2Zbhkr1sDb
	 iUXMIMKaQb2zhZS34S4/A996nWwLQSCZSlRUim2SAxOZhImqdDOglLBqKqaldXA6+q
	 QBkE/vVM49vmQ==
From: Benjamin Tissoires <bentiss@kernel.org>
To: linux-input@vger.kernel.org, Shen Yongchao <grayhat@foxmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, stable@vger.kernel.org
In-Reply-To: <tencent_6C4272FCE4F12C891C300445A9D8E6C68C0A@qq.com>
References: <tencent_6C4272FCE4F12C891C300445A9D8E6C68C0A@qq.com>
Subject: Re: [PATCH] HID: bpf: serialize device reference release in
 struct_ops destroy path
Message-Id: <178828141395.3609331.5090600854175657946.b4-ty@b4>
Date: Tue, 01 Sep 2026 18:50:13 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2

On Mon, 03 Aug 2026 22:31:57 +0800, Shen Yongchao wrote:
> __hid_bpf_ops_destroy_device() and hid_bpf_unreg() can race on the
> same registration reference, double-putting struct hid_device and
> freeing it while hid_destroy_device() still uses it.  Serialize the
> remove/NULL decision under hdev->bpf.prog_list_lock so exactly one
> path releases each registration reference: unreg re-checks ops->hdev
> under the lock and returns without putting when the destroy path
> already cleared it; all put_device() calls happen after the lock is
> dropped, which is safe because a concurrent unreg then observes
> ops->hdev == NULL under the lock.
> 
> [...]

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git (for-7.3/upstream-fixes), thanks!

[1/1] HID: bpf: serialize device reference release in struct_ops destroy path
      https://git.kernel.org/hid/hid/c/9cdc7e6dc7a9

Cheers,
-- 
Benjamin Tissoires <bentiss@kernel.org>

