Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.142.180.65
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793092734;
	b=PyP4Pge4ObT+ziRw9urD/FYsEq6LKHbA9SXXF/Cx5OAkI+jfkgISKMWLpZU69hxnEf2y
	 vwc66C+LJdAPb18SDTSsY1Blbv+nFZx3gTX5B5HHRxvBsRcVx02sowBMW8H4XSifY7WU2
	 7/cQuOD8gA1JV7R8ej2irLN8bNpDEttNApMZ3pK6mDQyTtz03jEnox6wh0vlibS7jct/b
	 Z80BYO0/aeviF23QKIyNYC4mjLcFax1Z0svTaEKRHCSarzlHDfH7SCxqPZOdLNmdS6enX
	 yV4014zApFCP+CM121u6p13TrQj7NfnEoHBWQC4+PzJss7PNxoNFg6RRvjgIYTyZc9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793092734;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=X0pd8nSiY8Zw7J+PG/0C4cmjY7lSYmmgt38+MBBu3fY=;
	b=2uHuvyrlNmrwWq7RRVZ/Zv08LzURm0D2aElS+UQpavRCY/GOGnriGdWYgiGsgG3R4Z/A
	 mI3zxDMlpAtVXRg5GI/BbGgbiAI+SzZiYq3zBcQM+0d1v3S9Pjxbge6pZONvw7QkJ6Maz
	 sl/cWNpNfI8sxilhpbzMKDd0rHYFkxx6QQWxjosfQ4DhAy1W79WNtdbeejrbWb2R1tDiX
	 cCVpwMzbgwwA/8jq6hVQW54eEAl//4WZ74RzCpamDSTYJVR8SP93hQdlyk2TRnO12Yocm
	 VvhLizugJ7rwho+4ivOFv80Yb72+PmFf6+SZWpr2FPhueCTulyoNUzG+/OikoOA5iQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=makrotopia.org;
	spf=pass smtp.mailfrom=makrotopia.org;
	arc=none smtp.remote-ip=185.142.180.65
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85F4606A31A;
	Tue, 27 Oct 2026 09:18:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E85F4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768)
	 (Exim 4.100.1)
	(envelope-from <daniel@makrotopia.org>)
	id 1xLdHD-0000000021l-066a;
	Tue, 27 Oct 2026 09:18:40 +0000
Date: Tue, 27 Oct 2026 09:18:38 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Vishal Satle <vishalsatleit24@gmail.com>
Cc: Richard Weinberger <richard@nod.at>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Zhihao Cheng <chengzhihao1@huawei.com>,
	linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] mtd: ubi: nvmem: Fix device_node leak in ubi_nvmem_add()
Message-ID: <auBsbmS11_TQTryC@makrotopia.org>
References: <20261027091507.130294-1-vishalsatleit24@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261027091507.130294-1-vishalsatleit24@gmail.com>

On Tue, Oct 27, 2026 at 02:45:07PM +0530, Vishal Satle wrote:
> ubi_nvmem_add() calls of_get_child_by_name() to verify that the UBI
> volume device node contains an "nvmem-layout" subnode.
> of_get_child_by_name() returns a pointer to the child device_node
> with its reference count incremented.
> 
> Because the returned pointer was only evaluated as a boolean condition
> and not retained or put, the reference count of the "nvmem-layout" node
> was leaked whenever an NVMEM-enabled UBI volume was registered.
> 
> Assign the child node to a local variable and release it with
> of_node_put() once existence has been validated.
> 
> Fixes: 34a5d8525b6a ("mtd: ubi: add NVMEM support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Vishal Satle <vishalsatleit24@gmail.com>

Thanks for fixing this.

Reviewed-by: Daniel Golle <daniel@makrotopia.org>
