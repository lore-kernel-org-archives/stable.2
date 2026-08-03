Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BADD322B9F;
	Mon,  3 Aug 2026 09:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785748185; cv=none; b=h5PM/ubuTfe2q9ufQ0OOem3qlR+8JdgYhNbCDtYQSuQVxGIZdZofiQbdKPsAjWnYL8rl3LkW3rp45mbqeTghfyNTwCjq4k6Z64RRmN8bLOUf/1VJRkNk4uXr7sSB6L8dFs0ztyrQCpkuUwM2XmDVY7qjuwlD2Lbl7/KItcdInlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785748185; c=relaxed/simple;
	bh=gBZnHxDnaLIZENE0VoGMb4mScNkBIXBUC2f5cTilUg8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=N4ZKVMgpv1VHTnFRgSdjYjY+TYn7cB7Vrb3hvIkDlOyvrydftHbDfXTrNqfvMVklyAjnJ75dNIlS5g0o811ukx/sC1A2nCtXwVw/IWJQJ3LGSZyROsh0I2H8OjD5eNWWJuLfLGKFpg38HMKL0AYP+75VgJhr1gVlv5YyP2SFPMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=ehd3x7MA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iRBkVE6g; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="ehd3x7MA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iRBkVE6g"
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8F24A14000C2;
	Mon,  3 Aug 2026 05:09:41 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Mon, 03 Aug 2026 05:09:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1785748181;
	 x=1785834581; bh=ROWwQWFfRqP3UQjuKRqW3Dif0oPwvL5nYK49KQT7MrE=; b=
	ehd3x7MAo4z0ZuMNrudSlC7fak5xAffSOUyAEMWw8jMp0nSxkUdC2rh/ePCGUcyQ
	xn07wQpzHkbmOmh3lER/3KdFBlzQ6N2JgDFWwSal+rvLHsD74RfeSyPQEMevNQ1d
	UXNHn9YzjE8me03sc39cvnMAINGcN4qTTnw3L4/cIPmk8IuEUjLVyfdmo/El3OiU
	QBSLtmcDdZ2WClYV3PckZkewfDTMRb7UERQHmlhGd0LzsdKtVZHE16MMbMOjYyt5
	dqRL0jU3XY/VUoYoOiyjmkQFST0CPY+M2vRaBjg2refKaQFeSdcGpw1G+2zW+GAJ
	xpGTXcKT/+7hD0S31zf9UQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1785748181; x=
	1785834581; bh=ROWwQWFfRqP3UQjuKRqW3Dif0oPwvL5nYK49KQT7MrE=; b=i
	RBkVE6gTql0F0lZQlFR9Q6fehRxiAK9dDBOPSK7u9L09oLy78KwIkJUIQVvdHffd
	EJ4AewrA19exTEz9QohDiAoOw4mDmR1MDH2mb3ufKfC2Ykd+iE4XDxjOIACt3H40
	OesozbuP4WTDTkAxvHohsjPV8Yw1HfJddAozJZcfXJvHSaewqd04DRiTuu0C7j5g
	Ocd8aQiOWEjJyuXzi+D5p1QWLoPwFoPlqVyhYVdl/j0jku4UG8PnH9OhbgyGVHW1
	k6avb55/dOG7OYEoiHyffSuneHU9gRmPhh1/sL0cD//hl4VtrosF11gJl1WJ3RoF
	hXIjewwH9e+Xk9bQz0G2Q==
X-ME-Sender: <xms:zlpwagHHW8TpDsxD4ZdM_MOfSvDiwotN_TYATY3wOoA65Of-kPHqGA>
    <xme:zlpwakJ1WT5ET_uvRf1bkzRgx_tYpCJ1mQyfSpa0i8qVxuDVUimdHjFryHWYnlbKs
    CSeHCHsiSsRs4ZgcJwRG8FEpMEV_PUU-xOmHmHqbtMEOREiD2m1Wrx1>
X-ME-Proxy-Cause: dmFkZTGEoBb97AL/SKgK0FdstT6EoWymHRufnb9mbxxW8IG8NdO7glMPqxR4yHoQFSM33G
    8gcn4L2BISCqUtopUVwwjCPignrJRrMJrQOmKRmU7ovMRuIrXnVzMKXqfi/m3rAEI4LOuw
    TyT6XQlWkqvDIaAe1givBclBybzdg29F3ddGQiHdSw9ewpDzGPT/4+tRICZmoqqIS/TIWF
    dKKsodWG14FJplIWbNJt/6/9IA2b8jod08Ez7V7Q/XabFFN3b660uesSBRXtfrXuN3W5Se
    vaFwDnRk3uyRIM8sC2g+9R8Uj8r5YwtLYk4GTVqD1+S7lqq0/PULBz+5rHS2zrKHzM2RuG
    7AuRBuh9dhHUdXYROVL/0hXJoK3qbr5000a7yL5ld4JMIYMwFi9UcQgevm3FLrosbkdwan
    s0lFp+AYylhI9VAnKiRoS/j0gwrMqnzFltpAWd1ubHdwZYE0D2ZHKKD6scF3DSXCm0vQ6H
    E/oGe7JOuhQlEbJLdN+0gQ02R0sAru368VZADgE3oYm7lwCnzBrUeIl4RS5l6wRsCO2lxW
    OhUEABUtT0gIt0aVGlBh4bixDmXHQPrFK6jhoMmpD88auS+QaTXRxCzGoTrwaMHTCO1Dk3
    VXZyS7uaA85QCY80YeoQTuyGxLrLx1o/Q9kMwdzJid0891QDps4XeBuw7x+w
X-ME-Proxy: <xmx:0Vpwasm96kHvmBQ2erPVppajueqtq25YEnn1_MZ9dDDeY2l7NnCzpw>
    <xmx:0Vpwal5vq9MHmTRGxkHs9PskslKbuGtDxWa0vYe0-daY0o9BWBXx9w>
    <xmx:0VpwavkqX2IFCm4qh3eKObpDa_j3AYr9S_myt4EDZ9sqJ805Fxfqbg>
    <xmx:0VpwagXlmmhrHmfm1pkssbgfzBKK8_mnGzO_0vI7ILyP_igT5gpxUg>
    <xmx:1Vpwajpo7m-nHJyFy0nCKRDFfvACEbS00sx1IBUTTb-z4sqKsDGJ7NhW>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 83E6032A0060; Mon,  3 Aug 2026 05:09:34 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ANyXKwt9w6Ig
Date: Mon, 03 Aug 2026 11:09:13 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: moonafterrain@outlook.com, "Madhavan Srinivasan" <maddy@linux.ibm.com>,
 "Michael Ellerman" <mpe@ellerman.id.au>,
 "Nicholas Piggin" <npiggin@gmail.com>,
 "Christophe Leroy" <chleroy@kernel.org>,
 "Paul Mackerras" <paulus@ozlabs.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 "Yuhao Jiang" <danisjiang@gmail.com>, stable@vger.kernel.org
Message-Id: <a6c11272-044a-4f9a-9cde-68e1f12798c9@app.fastmail.com>
In-Reply-To: <20260802-fixes-v1-2-7368423440f4@outlook.com>
References: <20260802-fixes-v1-0-7368423440f4@outlook.com>
 <20260802-fixes-v1-2-7368423440f4@outlook.com>
Subject: Re: [PATCH 2/6] powerpc/spufs: don't leak kernel stack via spu_run
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, Aug 2, 2026, at 17:51, Junrui Luo via B4 Relay wrote:
>
> Initialize status to 0, which is what userspace would have observed had
> the assignment been reached anyway: spufs_run_spu() resets
> ctx->event_return to 0 on entry, and 0 is the "no events pending" value
> for this word.
>
> Fixes: 67207b9664a8 ("[PATCH] spufs: The SPU file system, base")
> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Junrui Luo <moonafterrain@outlook.com>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

> @@ -37,7 +37,7 @@ static long do_spu_run(struct file *filp,
>  {
>  	long ret;
>  	struct spufs_inode_info *i;
> -	u32 npc, status;
> +	u32 npc, status = 0;
> 
>  	ret = -EFAULT;
>  	if (get_user(npc, unpc))

I think I would prefer skipping the broken put_user() in case
of an error, but your version also works.

    Arnd
