Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92DF3D6470;
	Mon,  8 Jun 2026 15:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780933081; cv=none; b=WwSzA71lni6SyMFLevHbFOKVOwJFV0nhC1SIfxwmkK8tEVR32fnTZDw/1trg/dGehODXwwkI1+0kQhTK/MN6t7k1kmv9nfE2HKWoaMH36TMPyaoo6rJJRWQ6U1pFCkDJKJGZOOmIMR/BdAXPQ3cwx85k2hsTK6OHLEqLt0wK0iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780933081; c=relaxed/simple;
	bh=C7SuUEWQaeL4m2xGyeBZXl7e5MDFSYw6ltyy7OwszOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QWdTVXktHa4if1l2Q+N/g0fN0JbeaL/J5rHORuFEDtSitPeEmrC5EiC9O+HXDgzUP1QXALT5yir/VP2wWwTAMjjmHpHo+wUbCbqw80fPt5m7Hl7x7Nt9zoDODL8qo7pxUrc0hnuYBLIKorv/RBUtkml7recapnq/+UcIGCuj1/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jPrY9FFQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jPrY9FFQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF9141F00893;
	Mon,  8 Jun 2026 15:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780933080;
	bh=08S2aTd0jdKvtqZ3MAK8kIbIKA+BvzVtDPiX/U5yXNk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jPrY9FFQEb39kfIInwYZaseN+PPqYxlyzVIqVpT94IJexyTF82ZbUWx2NxnpZVVxF
	 54niFLRxIvooe1PTCQk+0vleMZzOYkdjVGXYwISq7IaMqEz1NOiZpL0VMYOFCbFP0Z
	 relg5lhreMRkj0EKIZqyG01mSE4Vey7pYcu3NtIh0CSVh9jQzYaIy03EyC+g9ctLjB
	 DDF9nZ7eLNhNWR9f/X4cyH6x2hBccUYt5EqZjqRhMBm9dYe9E4TuWCwR+wLgHly6zj
	 iD/GbkPBV8Yck9m2ggMUZ+5aAA+Wzrm9r/zBmKhLYIldvbEsHcx1xn6YX6pIVt8CDr
	 MLR6owHJQtAAw==
Date: Mon, 8 Jun 2026 17:37:56 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: chris.brandt@renesas.com, linux-renesas-soc@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] i2c: riic: fix refcount leak in riic_i2c_resume_noirq()
Message-ID: <aibhmDQPlT89IdxK@zenone.zhora.eu>
References: <20260608071123.128964-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608071123.128964-1-vulab@iscas.ac.cn>

Hi Wentao,

On Mon, Jun 08, 2026 at 07:11:23AM +0000, Wentao Liang wrote:
> When riic_i2c_resume_noirq() is called, it deasserts the reset
> using reset_control_deassert(), which for shared resets increments
> a reference count. If pm_runtime_force_resume() then fails, the
> function returns without calling reset_control_assert() to
> decrement the count. This leaves the reset deasserted and the
> reference count unbalanced, which can prevent other users of the
> shared reset from properly asserting it later.
> 
> Fix the leak by calling reset_control_assert() on the error
> handling path for a failed pm_runtime_force_resume().
> 
> Cc: stable@vger.kernel.org
> Fixes: e383f0961422 ("i2c: riic: Move suspend handling to NOIRQ phase")
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

merged to i2c/i2c-host-fixes.

Thanks,
Andi
