Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CF53EC2FF;
	Tue, 18 Aug 2026 19:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787079981; cv=none; b=Ev75Ow5x9WUNoBC+kfCEz5hqzFr8M3JS/OyG9/cVjLDoyNNwl+DUcFt5LSEcF4sIygl1zwhZ+ma0PAx5pV510nKlSOKYrYm04xuSL44mf3Ey0uQZihn53DxZxlj9LoEyj3j+Z/WCBeXw//Tq8yEmVMwGWBH/i99cgsB3V37ya4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787079981; c=relaxed/simple;
	bh=3y7KlyBbyTwF2kNZlJEnsO+aeV4LkXrOERAaoNY+r0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FtdbTn9IjY2tlzgyF0DsMbjNcfZc3ciHuKiVoInBATeO5P8CiBGGrQB8ZwB9MBng4QkLqWgaaj8scKY332EDPfVlhGRk7QqOYomHSbiigzoJA5+GvHh7N1w6WkhzGenVqC8oITFN4ADkww7a4Q3Qo9pgsz/5RcLpm1PtFjdyQ14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R0asX7U6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R0asX7U6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6039B1F000E9;
	Tue, 18 Aug 2026 19:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787079980;
	bh=uFd0SqHI7GrMRXheHXKaCorLnEBVe2vzTvlP36T9HRM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=R0asX7U6pH0vejhmDYKTGRIyBPq0/z0jF0DFRytL5twBwdMy8VOqAzSeCuTUJBmCZ
	 OmGhdEeIywech6egWQ8jpHL+WBDxAfldkiBn0xvTKSXUSNh1mm1yN3ypueUOAh2Doc
	 LalK/nMwixKgorT75SNKp8wvkA1AsEYeLHkqANBlFe/0xPH04slU6kwqK4+v6l1aOv
	 6ObpkcxwjReYVQpjG297jyyRzxJAaFjhgcd/1dxvfTuLBJQctBR+FPX+itVBTiObm1
	 uxZSYNA1ansZ+Aq5BGbIfYYOywRWgFoj73WhASJeh+yG3op5bWkbWnL2rVKGsrQ1zt
	 wpVM1s2BjMn7w==
Date: Tue, 18 Aug 2026 20:06:15 +0100
From: Simon Horman <horms@kernel.org>
To: Jiangshan Yi <yijiangshan@kylinos.cn>
Cc: skalluru@marvell.com, manishc@marvell.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, vladz@broadcom.com, eilong@broadcom.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	13667453960@163.com, stable@vger.kernel.org
Subject: Re: [PATCH] bnx2x: fix double free in bnx2x_init_firmware() error
 path
Message-ID: <20260818190615.GJ265046@horms.kernel.org>
References: <20260815122149.951215-1-yijiangshan@kylinos.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260815122149.951215-1-yijiangshan@kylinos.cn>

On Sat, Aug 15, 2026 at 08:21:49PM +0800, Jiangshan Yi wrote:
> bnx2x_init_firmware() frees bp->init_ops, bp->init_data and
> bp->init_ops_offsets in its error path without setting them to NULL.
> The cleanup function bnx2x_release_firmware() frees the same three
> pointers unconditionally, so if init_firmware fails and
> release_firmware is later called (e.g. from __bnx2x_remove or through
> the function state machine), all three are freed a second time.
> 
> Set each pointer to NULL after kfree() in the error path so that the
> subsequent kfree(NULL) in bnx2x_release_firmware() is a safe no-op.
> 
> Fixes: 94a78b79cb5f ("bnx2x: Separated FW from the source.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>

Reviewed-by: Simon Horman <horms@kernel.org>

