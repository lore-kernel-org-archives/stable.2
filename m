Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4810C345ED1;
	Fri, 14 Aug 2026 12:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786712361; cv=none; b=uXx6abMXmDUwxPsRoO3aupoPrC9CgMcSRawM00tPCLooRkPzWEgFepUhxwc/mdvLaDWDYkmF/pvFg9ViAYYrBYkYmqwREeANrhSBEqk4IoQC6e1EtdDMlclYH/AqTrgN7aK5QKoBfdAL1xf+iHwF3WWacW4PgRZ2wiWc0CKPwCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786712361; c=relaxed/simple;
	bh=pSfjsqcP7NDshZ+FNkjFIUTiFc0TrWS4nPAxVJ5mIG8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nkwjDpA5UHo7oindk/pQJvPrj7+KuKTJ08TLE/SIOoQRP9+OQeeYnS53T0MwJMw4enmiAYmsBS8uUX81OQ30inCIA42oP0/FZC6JiS+9+OtYDYSXCQj9AjeC3lDi6E8WqaNlOR12CEDPU/lgWehbOfRoKG4MElePBGgrsu08Xac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75A821F000E9;
	Fri, 14 Aug 2026 12:59:15 +0000 (UTC)
Message-ID: <36f9089c-64cf-439e-acba-5181818a5ad3@tuxon.dev>
Date: Fri, 14 Aug 2026 15:59:13 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] PCI: rzg3s: Fix IRQ domain initialization error
 handling
To: Prabhakar <prabhakar.csengg@gmail.com>,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Prabhakar
 <prabhakar.csengg+renesas@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>,
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 stable@vger.kernel.org
References: <20260811200013.185956-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260811200013.185956-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20260811200013.185956-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/11/26 23:00, Prabhakar wrote:
> From: Lad Prabhakar<prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> rzg3s_pcie_init_irqdomain() installs chained handlers for the INTx
> parent interrupts before creating the INTx irqdomain and initializing
> MSI support.
> 
> If any subsequent step fails, such as obtaining an INTx IRQ,
> creating the irqdomain, or initializing MSI, the error path returns
> without removing any chained handlers that were already installed.
> This leaves stale handler and data pointers attached to the parent
> interrupts.
> 
> Add a helper to tear down the INTx IRQ setup, including removing the IRQ
> domain and clearing the chained handlers. Use it to unwind partially
> completed initialization and from the normal IRQ domain teardown path.
> 
> Fixes: 7ef502fb35b28 ("PCI: Add Renesas RZ/G3S host controller driver")
> Cc:stable@vger.kernel.org
> Signed-off-by: Lad Prabhakar<prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
