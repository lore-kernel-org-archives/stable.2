Received: from mx1.mythic-beasts.com (mx1.mythic-beasts.com [46.235.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8F13A8745;
	Sat, 30 May 2026 12:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.224.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780143645; cv=none; b=Ax8+29ETkVeGywuN8mkhW4EU2w4I5+i9htOc321mKNZ1/GVb2yQiQD6/F2vYP36A384jAprpwqtt14l96OEzlGboFFz0PVb2lT5tFoDvi7zkK+GQW4xclbArLFf3CC7cBCN36fWE9e3sJllazJ3H3R6IaLjEYdBvmBJGl7DHQgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780143645; c=relaxed/simple;
	bh=z9TGfrh25gMJK60Ksr3hjdWAAv+YD9PAsiqQbrfdCck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uQtDkduvyzd1NdDrwqIjkhKrASDTSosEuTqxLlLRPVMqYw7yu/HpJZjxm8VWSGvGLk1n5lX8pynsskD4pzOfp+1xYejr1lCHOpreZYYA1tLWIfOZzOIyQKKWyFB7r7dv/vK8rlJm4c2tcGLDRhXZjqHMesik5B6fsUbFPhGqd2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pelago.org.uk; spf=pass smtp.mailfrom=pelago.org.uk; dkim=pass (2048-bit key) header.d=pelago.org.uk header.i=@pelago.org.uk header.b=lRvwPj3L; arc=none smtp.client-ip=46.235.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pelago.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pelago.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pelago.org.uk header.i=@pelago.org.uk header.b="lRvwPj3L"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=pelago.org.uk; s=mythic-beasts-k1; h=From:To:Subject:Date;
	bh=z9TGfrh25gMJK60Ksr3hjdWAAv+YD9PAsiqQbrfdCck=; b=lRvwPj3LrPFmr+AX5sy96DlrZC
	xTuqgI5gAt36etkVxW+9Cf87LbucvOxkdG9J1F49Tdd3AkPtwq5QTbGYwwdykRsRq93jKyXfeWJPC
	32tMFXgeCwx1qj5ltXnaeJhcjPp+NDiJc2v+JHYBRCNHOFwwGOlON7r3ubduXyi6MGFuCLek9j8ch
	fmPhjtYBvNcJ9llgyxbWbZJoR72GVWpmgX9FbbKpir9lxXAaiTbvQxhNxZv7yTsvCT0sYTKei6lIy
	NGjC+3cO8CR/LBVcBoKHLJsGO1WqbVQ2/q4yghMrDmuOhuQ2265bfPyyvcISWs+IIcsZAkT2eVZfa
	QdfId1UA==;
Received: by mailhub-cam-d.mythic-beasts.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <john-linux@pelago.org.uk>)
	id 1wTIfz-009gDs-35;
	Sat, 30 May 2026 13:20:28 +0100
Message-ID: <bc9d5258-d4df-46a1-bba9-de3486f722ab@pelago.org.uk>
Date: Sat, 30 May 2026 13:19:58 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Toshiba Fn keys + lidswitch
To: "Rafael J. Wysocki" <rafael@kernel.org>, Nick <nick@kousu.ca>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 regressions@lists.linux.dev, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 todd.e.brandt@linux.intel.com, xi.pardee@linux.intel.com,
 platform-driver-x86@vger.kernel.org, stable@vger.kernel.org
References: <E2OXET.4X5GTP37VTNC3@kousu.ca>
 <CAJZ5v0jVQyWYqPo_MiUwNQb7FLNR_Q_++Xq=xA1owcHpcjN=OA@mail.gmail.com>
Content-Language: en-GB
From: John Veness <john-linux@pelago.org.uk>
In-Reply-To: <CAJZ5v0jVQyWYqPo_MiUwNQb7FLNR_Q_++Xq=xA1owcHpcjN=OA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BlackCat-Spam-Score: 0

On 19/05/2026 15:08, Rafael J. Wysocki wrote:
> Thanks for reporting!
>
> I think that the problem is acpi_setup_gpe_for_wake() doing too much,
> I'll send you a patch to test later today.

Hi, can you release the test patch publicly? I'd like to test it here,
as I have several Toshiba laptops whose Fn+keys don't work (apart from
vol+/vol-).

John

