Received: from mx1.mythic-beasts.com (mx1.mythic-beasts.com [46.235.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3328E30E0E9;
	Sun, 31 May 2026 15:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.224.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780240695; cv=none; b=cuQw3hfIw/PK0yb4WyaBH8nPfzuuZ4201bet1ydbXnCesZdyj4sqs6qcgUCDJd+OclnvZHapD0occOgjTa5LtSMlxXVUGhWzZb7F0oGriiZVtJJXxC6Na/V36B3b0H/yPqfMNi3uaVcp8HJFxfjrml1jyjBS9anfY/LmIw14JRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780240695; c=relaxed/simple;
	bh=rhOTB4kvjmISDBctDwT5HOz93gVp+fe2NG4uXfye8nc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qjyaiJ2u0hBD5Va+FbPYEarBYOn3HCbY13For1l4kpCupa1jl5i79IZs133gf8eRBPHRiOOQkhQj/CuY/JEphadBJNCunbuPUmWabtdea1mdCcZN8/i2eQxF2jmBmB+eP5kOBi75rpVeOFzO6f4rsPCN00T9o4PdvimhECp61Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pelago.org.uk; spf=pass smtp.mailfrom=pelago.org.uk; dkim=pass (2048-bit key) header.d=pelago.org.uk header.i=@pelago.org.uk header.b=XDNrlPVK; arc=none smtp.client-ip=46.235.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pelago.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pelago.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pelago.org.uk header.i=@pelago.org.uk header.b="XDNrlPVK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=pelago.org.uk; s=mythic-beasts-k1; h=From:To:Subject:Date;
	bh=x3VT+5iyicJEVrdyWbzkEK72fKPATPivo6/EvwZumBw=; b=XDNrlPVKHWbauR5caD5Hsk9xJs
	m5fG/kzn/NXDY7GbTEOvIfc6eSxmb846M90d/mDs5vRkm7kWIf4M/nEDcwvTkk+zOxRrH3FYyBTGN
	iRwp69DT9dvhFuw/WeBMDWmqeJ1eKlD5YCH2GXJxB/FDlIPOUyGzcNahrWFg1LWhm/5ee78FkxMEH
	JJwJOyIeBaoiSIlcnauLeFz1KC5p4+BP2ioY47I2THZgkS96g9e+Shg5C2YTwmNuBGnDhbR1fncmf
	S1bliDBFLTgnmC//0wOYAFJ0ILJ+oQPZWIYRfCpkRBUK9VVwpW3KWZm20NCDK9rhd+fFV2PkRFtxb
	JOAFxwTw==;
Received: by mailhub-cam-d.mythic-beasts.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <john-linux@pelago.org.uk>)
	id 1wThvE-00Ddc3-2t;
	Sun, 31 May 2026 16:17:53 +0100
Message-ID: <75398536-2ca8-4205-9205-18afc5227397@pelago.org.uk>
Date: Sun, 31 May 2026 16:17:24 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Toshiba Fn keys + lidswitch
To: johannes.goede@oss.qualcomm.com, "Rafael J. Wysocki" <rafael@kernel.org>,
 Nick <nick@kousu.ca>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 regressions@lists.linux.dev, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 todd.e.brandt@linux.intel.com, xi.pardee@linux.intel.com,
 platform-driver-x86@vger.kernel.org, stable@vger.kernel.org
References: <E2OXET.4X5GTP37VTNC3@kousu.ca>
 <CAJZ5v0jVQyWYqPo_MiUwNQb7FLNR_Q_++Xq=xA1owcHpcjN=OA@mail.gmail.com>
 <bc9d5258-d4df-46a1-bba9-de3486f722ab@pelago.org.uk>
 <8503d297-68ca-4bfe-bbdf-537a85890d86@oss.qualcomm.com>
Content-Language: en-GB
From: John Veness <john-linux@pelago.org.uk>
In-Reply-To: <8503d297-68ca-4bfe-bbdf-537a85890d86@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BlackCat-Spam-Score: 0

On 30/05/2026 14:34, johannes.goede@oss.qualcomm.com wrote:
> In case you've not seen it yet, Rafael send out the test patch
> publicly later that day in another email in this thread:
> 
> https://lore.kernel.org/linux-acpi/12896447.O9o76ZdvQC@rafael.j.wysocki/
> 
> Regards,
> 
> Hans

Thanks for the pointer, and sorry for missing that! I had only been
looking in the archives of platform-driver-x86@vger.kernel.org which for
some reason didn't receive the patch.

John
