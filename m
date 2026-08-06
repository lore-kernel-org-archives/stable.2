Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFCD309DB5;
	Thu,  6 Aug 2026 13:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786021463; cv=none; b=ePxwSs3faCvNa9Thwb5fkc+7fIqDY9WutIr3nIbACXaFRfRoNmVrj48agBjsMfRL7LhxZ0AA9LIBIBp7XHr+s95EHErq6zW8zm9pLAqwfNZAKNMSbi89/wKQGOF3pMEIzFfrn5JVBK6ntDaRmVsW4ET2uXEz7cmaBkqX6S6aawg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786021463; c=relaxed/simple;
	bh=+7FT4EboqdHt/DmXHCPU2cyTT9mS87btSOR8o2VdqXg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=i3YIleER6x1nnrdqLqUqjE0YG6BRry2ZhspxTwJBE+915j8ji3ayCde0oFjnUMQ3HNWwTUA4CXX50K3bK5QpnCl1SllUdQwuse+NcV3HD5/nDeHXpM5BxRmcDtcth/wntKhWKBkqXMjBRBNiWcQ2w7MlKNvocckW99fxuUl82xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RZ495Kdn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RZ495Kdn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC96B1F000E9;
	Thu,  6 Aug 2026 13:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786021459;
	bh=fSq6ekny6aI6aUM2ySyrR4eFoauq6IkaKKzWx72lcU8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=RZ495KdnThCEuZzPXgFsX/EhG708E1ml4Lm9eYB1Z/Ml0wTApQodgEdtZLaPLqsJv
	 VUy+mGuF+t1Bq5C/AMnn34/nAhtDRpv+3ufNzicZHViwPKwYn1rKoXhsZWW+uA/IPl
	 t4tmCZYNDZ1eMFi0zvusDQm6cThjfxNAHxTx77Mct7xe/uosTKx14YsB2E+Sfjvmuj
	 i0WunafOucdmUJEVr6JHOkde1BdZkorbiq0JufQeFHFL2gs96yUobmlBcQBFewYGDP
	 Y2lQJuSVkeIGT8ht4LR+3btwsAghc9n8l5pdQuSkJg9TUvDHj3hXJrXy+TEQwsVJi7
	 EzeYAVAmHm/Ew==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org, Abdun Nihaal <nihaal@cse.iitm.ac.in>
Cc: mfd@lists.linux.dev, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20260720113836.73133-1-nihaal@cse.iitm.ac.in>
References: <20260720113836.73133-1-nihaal@cse.iitm.ac.in>
Subject: Re: (subset) [PATCH] mfd: sm501: Fix potential memory leaks during
 remove
Message-Id: <178602145870.2907500.16902396928055251260.b4-ty@b4>
Date: Thu, 06 Aug 2026 14:04:18 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev-ad80c

On Mon, 20 Jul 2026 17:08:32 +0530, Abdun Nihaal wrote:
> The memory allocated for struct sm501_devdata in sm501_pci_probe() and
> sm501_plat_probe() is not freed by the corresponding remove functions
> sm501_pci_remove() and sm501_plat_remove(). Fix that by adding a call to
> kfree().

Applied, thanks!

[1/1] mfd: sm501: Fix potential memory leaks during remove
      commit: 83feedd9d83c0c5199f98c72df0a6196b4aefb4d

--
Lee Jones [李琼斯]

