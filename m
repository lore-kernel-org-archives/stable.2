Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793704240;
	b=f6SWmIquBIQdfE8ITGe6mIAxVqcMzXENlUkKEIH8eGY4W94+bEX7X/ZVtG33gMwsSDWt
	 gcdqGxOrzBdIesoauEBPL3XOvGN7NZtderOkL02GN1eFgnV45/UOw96J0hvt5hZ45RlX5
	 c+L9INXM7X4H+f+06INpH8ra37K3yCZjfjSSSmIxKEVNcBiY30MKzktqQcW9vxZVDVAwD
	 4LeKKLyWDyAPjd/I+UkC+B9gZPEwLZxNHcqKSXGo/XbgC94w1fz83KWrNUC85u3tanF6k
	 k6XTpgs+kLvHxrr6dPEsGJ+SvTFPAC5OZ3kZZxe8te75dYskzUueP2XeRpIFXZYy25A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793704240;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=mEwIOTgOFQ/xOnsi+5g5rx2vlC8yYz8+GdpWkMmVPrc=;
	b=M5aGdTaqZhRw9zakye1kEDaEsl4OGPkRz4+pQIQ/pQOtpkNutv67o/ipV7fogid4wNjs
	 EfmFqpTqIu1Gigcd0p24wq6zxy1VBLohzdzDxGE8QkUz6xCaH5hfY+7KVSx9oXn5WIyZ/
	 +neM+6ugFUPu5URmA2ampF/Co9I+qQqj7+0PnLdBiOarDl8ovtDCPpwuCwGN0j1q63srU
	 uH5bvANK1ox6vwUgBBPMDP0wUU8beRazR97v8n7vYtdfnyEw2C5Zh1yqRx3DaRdPErGjy
	 2UdblqfBS6lIQf8GIT706FTUW2xNbOBUwJ/jGBCyUcgf/9ZBPm4wWECgYXf2VLcwFQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WEcBbzLs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED9D606C5A8;
	Tue,  3 Nov 2026 11:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WEcBbzLs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AC531F00A16;
	Tue,  3 Nov 2026 11:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793704239;
	bh=mEwIOTgOFQ/xOnsi+5g5rx2vlC8yYz8+GdpWkMmVPrc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WEcBbzLs1K5aUIsYHMJ2XMLN+Pda6ra/ttPYxWjgMByjya3S/NJC9neOKsIokWrtn
	 7+mBFfW9Id1CwxEHDIWKWkKD25SiBpUgwHHEEHoIbKBOiTB+iIEDCXU2KEk2Obo61v
	 J65p5zfpHdRzqnpPrnAdgJx9iyG3OSbI1KqPOAXVV5ZjxfWFLRhi4cgMKT78mo0TwZ
	 Ifb3T9M0FYOcpoxx8Swh3BNtxQieQHNNfwJB8pgeF1F6Fl8jLqPlxejJgDrs9fEnsg
	 1rqsNYOupVnG4N3FlN2zxKQQ2zfQlf8FVe2/CiJzpHX9q7EKjEyJRB15ka9JBbvjhe
	 ZM3Hopxr7XdZQ==
Date: Tue, 3 Nov 2026 12:10:37 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, stable@vger.kernel.org, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: keystone: drop host bridge reference in
 ks_pcie_quirk()
Message-ID: <20261103-natural-buzzard-of-ampleness-aaba0f@quoll>
References: <20261103104239.1373754-1-vulab@iscas.ac.cn>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261103104239.1373754-1-vulab@iscas.ac.cn>


On Tue, 03 Nov 2026 10:42:39 +0000, Wentao Liang wrote:
> pci_get_host_bridge_device() takes a kobject reference on the host
> bridge device.  ks_pcie_quirk() returns without releasing it on every
> path after the lookup, including the AM654 PG1.0 path that only limits
> the MRRS, so the reference is leaked once for each enabled downstream
> device below an AM654 root complex.
> 
> Move the AM654 handling out of the enclosing conditional and release
> the reference through a single cleanup label.
> 
> Fixes: 86f271f22bbb ("PCI: keystone: Add workaround for Errata #i2037 (AM65x SR 1.0)")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/pci/controller/dwc/pci-keystone.c | 45 +++++++++++++----------
>  1 file changed, 26 insertions(+), 19 deletions(-)
> 

Multiple things here:
1. Your team ignored completely previous feedback. Multiple times.

2. You use multiple identities with this email address, thus I doubt that we
   speak with an actual person.

3. Your bot does not even bother running checkpatch, right?

4. Nothing of this was reproduced nor tested.

5. Finally, the same feedback:
You sent multiple independent patches, to multiple independent
subsystems. The amount of these patches clearly suggest this was
AI generated and most likely not tested.

More importantly, you sent all this work without properly organizing
relevant patches into patchsets. This makes reviewing difficult
and might cause multiple reviewers to address the same issue.
Replying to the entire set is impossible and requires handling each
patch independently, instead of applying or discarding the set.
Maintainers also won't see the bigger picture of your work. Quite
worrying.

This is on the verge of hostile patch: bomb us with so many
contributions, we won't be able to handle them in efficient manner,
like responding ONCE to ask you to slow down.  Considering all this
is untested and LLM generated, I have even more doubts whether this
should be considered for review.

Please read kernel documentation BEFORE posting more work. It will
explain you how to identify subsystems, how to organize your work per
subsystem (so a patchset grouping multiple patches with a short cover
letter), how to document the issue discovery method and what was
or was not tested.

Best regards,
Krzysztof




