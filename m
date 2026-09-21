Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC022C15A0;
	Mon, 21 Sep 2026 10:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789984831; cv=none; b=MOpT1HMSRgsjgw52xqAkI5pIjxuEueAt47ADzLdEs8cfWPIRN9v2yNWzt99/w81qpWkMrVn+hDphETw4ceE46oKUE4ovTGjrVRMTnkZaaWR0rTY68elUCmhNvAOhv/L/UhVfbGLjjz2gwOw4GRBDn6cU+XHoGw3WzP5INIcj84o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789984831; c=relaxed/simple;
	bh=tWY19dcoFHXDmJAUhSNDhZfsNMNeWSyR8xwJfJSXA4Y=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=GzeFl+dPKmL/cyzKukujuF6pZhCRZrrb4u2x3noyWtUVp6/8glB8aqA0s3TifBOtASEoFRvoOQgEDQBp+SwuEXqL+Z4l7w0xRE5Kw9asixRJKsVAVr0iIAf3D+nZHaZWtAnXSFCYuDZOiL8kH4+oXJZsOWQypEWHnsnZXwD6meI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=XGeoumtS; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="XGeoumtS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1789984764;
	bh=tWY19dcoFHXDmJAUhSNDhZfsNMNeWSyR8xwJfJSXA4Y=;
	h=Mime-Version:Date:Message-Id:From:To:Subject;
	b=XGeoumtSLRlDiJcHm8GgRQhmiyavsHMcQR2xDuo4Kr16vA/1J6wwShsCLw8CZ/A8X
	 ZS4Cl/1Mk4RXF0P7g0vxR4eEHwFZRQPC+3tXEE71vMGxIy48i8rve77WjY02hqHLZL
	 zZLDouQ6TmO21z03Fo1/9YH0CxieAy8iogite3aI=
X-QQ-mid: esmtpsz16t1789984762ta2036a00
X-QQ-Originating-IP: N1kqgUwUQ6CpnaXGst8q5ZXZrxjY3nWuvsEvA3sPBAQ=
Received: from = ( [120.237.158.181])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 21 Sep 2026 17:59:20 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14150466999559320817
EX-QQ-RecipientCnt: 10
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=219e651e61f225e66af934056fab0dddacd2006a3de520186a878c139085;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Mon, 21 Sep 2026 17:59:17 +0800
Message-Id: <DLKWN1PHE3UB.1RPIZRUKDJMFI@linux.spacemit.com>
From: "Troy Mitchell" <troy.mitchell@linux.spacemit.com>
To: "Xiaofeng Yuan" <yuanxiaofeng@eswincomputing.com>, "Anup Patel"
 <anup@brainfault.org>
Cc: "Atish Patra" <atish.patra@linux.dev>, <kvm@vger.kernel.org>,
 <kvm-riscv@lists.infradead.org>, <linux-riscv@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, "linux-riscv"
 <linux-riscv-bounces@lists.infradead.org>, "Troy Mitchell"
 <troy.mitchell@linux.spacemit.com>
Subject: Re: [PATCH] RISC-V: KVM: Fix IPI delivery for out-of-order vcpu_id
X-Mailer: aerc 0.21.0-reader-ipc2
References: <20260917122012.2577-1-yuanxiaofeng@eswincomputing.com>
In-Reply-To: <20260917122012.2577-1-yuanxiaofeng@eswincomputing.com>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MCXpTX1kEWEBsVV26uBpFHdhOGnrwBYhFbAU8AdRv8/m40mgU8GTCj/k
	wyC66Wtahn1FuofVIBZbTmP9Pmvfb5syWYnSpSQyxBsFdvwN3i123eocYnH95zW757Jvg4F
	XwlQ3pd3F8m8HiuLlRuGKXdfEjzlfbDCeUMwv9sIqgSiMKwRLXpdpX+K79Ioqk+VYWQVO60
	zpVnxRTSOaZ5P841JFLaYH2Bb9H+Pf+SPGiCU/IV3/1VNkPCBXdQ7fdb291K+FmbLuuHHO/
	R80aHrCU2r0wEtEGHbLa2kz26KhQSFqOI6AM6w/v0Gf2WvfjeN7TbXS7jkP920pId2zZsSn
	AOZIzF/tcF8m9BYlo+DUJB5HR1ciymIlZpdbAzWZkbzpwaIrUxNFiAOLT8QSj4f/x7z0EWC
	02E8XjFF0CBxdEbVpOx3+nQkaopUyBQ7UF4DL35u3YxH7mJMgkR2Fukr6ZkxLdLLrIYw9my
	9JJU3e+DS6qS46WLQ87AJhQb2mpiUpw0UzLiZdilijNxX5XX8gdXA+oSFWTbhbHCy1OS6lo
	qlFVQdWOnAmFppa2rRGHzj+jV9q/I+xWswetOuLxjso+7KnLn4xzCI/V7ZhU78/YpD2dIk4
	qhTIw4MUK8BUx2wKzA8KSi+YtpTE4YD6gC3nPcyhZlABNf1ck4rI6fKGmjg2mdiDZ/9yPRZ
	q4yiKe4JPMvee6Qn2qUklkUL4nMvPvn5fgMnBx7pFS3bKbxkDX6AmAB6T/sGig8WaM90YqN
	ZfsgLkTgHwHDaEjrGcKXvdmatLiX7O+svdXavJ09zH4AVGBkIH2mLv9dPJhtTmrDb4VeEnL
	DA3sqah5wux9arkA8ihdlx3A66Hty8PqAdiwEjPjpJDD1LvwIUrR72w629ZIhuxsbGsFKna
	dyYQ848o7bFSsPRmveqieAuy+wz9MXufz3lUMA6NAoOrTGFgT1IjnOZIBuUx+lSOeo07yst
	T1DUkdb8CcwQu+g3Wa4SupVOnXw3hIUiDMGkaUCPzqNI9ikiN/zSHCt2D+zAqnl3zPbcrqW
	DHxzAM4yhsz+BEMswMNNds+Uo5ABbX2Pg1QkjqdnbgGBgsGEPHJef38qgiJ15nI2ripqe88
	LGz8Ixg7Dk+
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0

--219e651e61f225e66af934056fab0dddacd2006a3de520186a878c139085
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Thu Sep 17, 2026 at 8:20 PM +08, Xiaofeng Yuan wrote:
> The SBI IPI handler walks vCPUs with kvm_for_each_vcpu(), which
> iterates by vcpu_idx (creation order) rather than vcpu_id order.
> Since vcpu_id can be assigned out of order by userspace, a vCPU whose
> hart_bit falls outside the XLEN-bit hart_mask range may be reached
> before vCPUs the mask actually targets. In that case the handler jumps
> to "done" and stops sending IPIs, leaving valid target vCPUs without
> an interrupt.
>
> Replace the early "goto done" with "continue" so vCPUs outside the
> hart_mask range are skipped without aborting the loop.
>
> Reproduced with a minimal userspace VMM driving KVM inside a QEMU
> (RISC-V virt) guest: three vCPUs are created with ids 100, 0, 1 (in
> creation order) and sbi_send_ipi(hart_mask=3Dbit0, hbase=3D0) is called
> from vcpu_id 1. Before this change the IPI is dropped and the ecall
> returns SBI_ERR_INVALID_PARAM; with this change the IPI is delivered
> and the ecall returns SBI_SUCCESS.
>
> Fixes: 0611f78f83c9 ("riscv: KVM: Fix SBI IPI error generation")
> Cc: stable@vger.kernel.org
> Suggested-by: Andrew Jones <ajones@ventanamicro.com>
> Signed-off-by: Xiaofeng Yuan <yuanxiaofeng@eswincomputing.com>
Reviewed-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>

--=20
Troy Mitchell


--219e651e61f225e66af934056fab0dddacd2006a3de520186a878c139085
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iIMEABYKACsWIQSL4Ay2cExaPXAQcU2YCe+A+TM0LwUCarD/9Q0caUB0cm95LXku
b3JnAAoJEJgJ74D5MzQvtYoBALNaq4r6dSilmdFKL0Z6RonhGyqeeGLzJqe/wK0C
ia1TAP9QtPHoNyc9u2LcOopl5BAEhOBmS72y7mpW4CFa7dxyCA==
=8dGz
-----END PGP SIGNATURE-----

--219e651e61f225e66af934056fab0dddacd2006a3de520186a878c139085--
