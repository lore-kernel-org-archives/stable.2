Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FF1280331;
	Tue,  6 Oct 2026 09:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791280751; cv=none; b=f31RtajBfjmnTBZvEUHSVXK/hNA+5j2aHx7WIKyadxa9MtKh385OcfoEoNRbkwpoZ7JT5N5NIuWW2fZ8Zg75CnV/zJrs/1ajuXXvq+kORrOhLQuD+nPjrcPdIF5mDufpR7hvqVX1NoO4cxePr4D1uj3hoEZkS8Qpty21/OhJyAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791280751; c=relaxed/simple;
	bh=oeSgVEToKy6aow+epXZMmyRWo4CwzKipH7QE77b9DmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j3JBVUW4K+oH40xc4Wc6FxOCHEfO2T+iSlTIZPdm6et4zjP+3n/zHz0VHHBx32hldSnMY8zg/3bCDARU/B7fb7TvmzpKCEFI5Wo0d/JfGQKatlaubmF/EqLMVcR9r2lytHw/u2YPh2gmIxMRoQzZp403Q8B0Ejzao7gmvQxr8io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ae5qConT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ae5qConT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 767CE1F000FF;
	Tue,  6 Oct 2026 09:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791280750;
	bh=oeSgVEToKy6aow+epXZMmyRWo4CwzKipH7QE77b9DmA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ae5qConTRtDe2EIx0Fu5mytBK9gV1JJiRo6uRYY+GrgDO0DE/2fxIIruK1KJZzk8+
	 HHtGAwJB5SnrH22PoM7fEzLmlOqsgiAy4/h618HOGA9n7ecIsvaE6wjkrwjW3FrZsv
	 i4Scab6FYfTaBLqipaxN5kQD6XL0ALCJMjDWbXIpubW5BMtL75tDKSJ/GSfodE2q/j
	 1HFMU04fl6AR51BOh0pUtwO5hdU51ds/9LKUkcaJFEUvVuylUDwIvtjDn4zTG9rdDL
	 rQCoRdJ+yh8+1gECoBOT1jkrlu4ZsF02Qo3+hfvStT6FjvXA0QsJa5dBnHTiSDlId0
	 PG1RRixUloTpg==
Date: Tue, 6 Oct 2026 10:59:05 +0100
From: Daniel Thompson <danielt@kernel.org>
To: david@ixit.cz
Cc: Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>, Kiran Gunda <quic_kgunda@quicinc.com>,
	Marco Mattiolo <marco.mattiolo@hotmail.it>,
	=?iso-8859-1?B?QmFybmFi4XMgQ3rpbeFu?= <barnabas.czeman@mainlining.org>,
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	phone-devel@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Joel Selvaraj <foss@joelselvaraj.com>, stable@vger.kernel.org
Subject: Re: [PATCH v4 1/4] backlight: qcom-wled: Fix NULL pointer
 dereference in wled_remove()
Message-ID: <asTGaV_---60n_Kp@aspen.lan>
References: <20260921-qcom-wled-backlight-v4-0-bab8c7ef73cb@ixit.cz>
 <20260921-qcom-wled-backlight-v4-1-bab8c7ef73cb@ixit.cz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921-qcom-wled-backlight-v4-1-bab8c7ef73cb@ixit.cz>

On Mon, Sep 21, 2026 at 12:46:22PM +0200, David Heidelberg via B4 Relay wrote:
> From: David Heidelberg <david@ixit.cz>
>
> wled_probe() doesn't set the driver data for the platform device.
> As a result, platform_get_drvdata() in wled_remove() will return NULL,
> and the first dereference of it crashes on unbind.
>
> Set the platform device driver data in wled_probe().
>
> Cc: stable@vger.kernel.org
> Fixes: feeab87b3072 ("backlight: qcom-wled: Add support for short circuit handling")
> Signed-off-by: David Heidelberg <david@ixit.cz>

Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>


Daniel.
