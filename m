Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793212715;
	b=tcUKxLAIHBqE18qnWRKnP7t3eaITLF9Kem78lNPCU89cyF7uq2R+XSjtfvlsMK75kXoM
	 zyqyfp52YnFrogJ/dYKtqJmdzAHZljHOmwAozXLSvbsfnNQKkT1tmPjf2KUB4ViXGRcUB
	 A2Nxae1taTIHlUOV5VqNS5nQGtNxyJUQG/7TLdIpTHF+5esM7FgXdDzmrzUMnwWpmnl5e
	 ck1Fx9sg8T/uPOxkRbYbLCwPuszCvjsbD44qNqVzO1VcSKN14q1rWT8EQq6ALlVHPdcgM
	 4lBNVEXxlDIj7oeBN2W7EcA9w42oSkFfZ5dYklabAgXhOfbZOczh71DsFCp5YoPi2Kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793212715;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=VpA17SHHGuwrQBIEjd+s24NC7TfJ/mBAwe7vJ4GIKtI=;
	b=q9Rrwn51tvLY1lGMLbHgxgCQXmPjdi0g7R+Xd25Pz6BqhL+aonTl8i2gXlSpgdBms9Je
	 2tOyPqrluYhC6ra6A2eEMn17uOFxaf/ExMvCtdqZqy/NHd/wP6ISAg8eT1x9CLoVAimgg
	 ykn0Wf/iNfpiGoZ8o183wOXAESdre2VqRbomLvCq4P6CB4MEejxDX6ix2OZ0K3oLv7Ct8
	 hoP4oYc/rsCDjP46SWWfD9DU33ncpbb4QlE8VlOA6iZmFSKglYosLLe0WZ5wYslhChDZf
	 yNb6ZX3jgci/vlNw2cvR96ntykWpryG3MrUYd7TL7iHlhwGLmHtREtHxyOD5OYqq/lA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E588606A323
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 18:38:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E588606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a207b02a2cso9379325e9.1
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 11:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793212713; x=1793817513; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VpA17SHHGuwrQBIEjd+s24NC7TfJ/mBAwe7vJ4GIKtI=;
        b=aQeeVIPMUiqwk6WocMaK2fvqFwOXq4+ME7x7LUdhEWRKNeI+L7qE3SAenqbAKKHIEu
         /dZzO+hCGRCttUuyJao2yyEMffqXY1XcIVpeVQuXvPFmqDkY/EY33VTXhu43HGxq74ZO
         +6o+Q/0xUxxMomTwd00jaif3ZMEwJPorfnEKewH/nJ0b6ROCYffVkQq5ewb6SwNj4ve/
         LINfOhDwFhSEUcRKmkKUyBqhxHlvw/7HKboI/1J3227wiS+ln5iiwurOKfFN9Tl/kmUo
         s1Tx15RkKcq9clTXL2z/wjGiazmRXGXXnDvJaRXjBuvJ+RyHV7TfQw4joB+c0v7Pzi8L
         iDIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793212713; x=1793817513;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VpA17SHHGuwrQBIEjd+s24NC7TfJ/mBAwe7vJ4GIKtI=;
        b=OGyhjSN6NNZ/bS8IDTU0bYhDnO5JKZCEL+dgrkVq0LXViwrNopFz8OQhavKYbsW4V0
         u/83Ul+HM8KmXy5Do3Vxx8mbS+s5JM5el+JKNFB3mjpTtnroJrbJqiTzKEMaoOcMY2cF
         z1+0/9a51K5UzYyP+drTxT6bkD9hfhivoGldVfL+Fx7nAEBw24t87tWScwDROFr/uk4O
         PIAm7kJje8fT12Ia1dtzvQ4rxUOCHg5RJo+t5NjA8nZOEvx/pLfsDW6mt0DdFi+cOvTQ
         uKCpG6Nd9Cd08nT2dR6/GWOCyS+C8cEz0UGg3BNeRosxnQDw/SBiPQA0l2QlSAgLudqg
         5uOA==
X-Forwarded-Encrypted: i=1; AKwUvBxahxYxPAd3mW+E6SPshdRVdJDlfGM5uI6IoWNZYPATM4CAiOyg2+LY5OuRXuycRoC5DWUGWjk=@vger.kernel.org
X-Gm-Message-State: AFq9FYLp7AWlN4joOVRFciLh9FU/vd+PygEhiPsT94qg9987TzO8YLNH
	OIlmkqod1SVuow22GwYNXMMiels23XpIVCd2P3uIyC9GlfPcfT50+RtX
X-Gm-Gg: AYBFou3NP/PL1N3/XajHWF9AnD/nH9+fPjsNFJSOvm/q97TDnzasYiMrA76TKRza+rs
	CrBKevHNISOPWE3DcL/0JLYYgsseSPTLjL1rV57BBDJg22AaLJQsM+21wDUWBzZ1C1ZrQ4GtvqG
	iZ8ou9MZ6N3xmfkFgLF8rQnLJ9YIcTNqkq22yAdul/DzAAqd3loIjZUkx9NwEnifuxpsBqUuxr/
	SXNPvOu6GDaU6qcJ94OvKzr0B4cAJ0GRzdZQn98JRLYVXEVbK3Mur3DeXrcCIrdn46HdPpntWY8
	nLbwZTjGB6/1A5vdZn3dlZKZ/ADodjP3XJsdC6D3+Cwr5Gq4rsWd33rKvvd94gNDzddrYTu3lBx
	LxRvu5kOS+W45RYx4rMBp29xOdeDaRIC2rY/Ne6TVqaVvwHhXCQdcPBWoYDPZkAXrB+q3sn8zD5
	R6yZf0q/BxY5Q604oIRxFG+Gmf2ZcLrm+HdRj4cyJsZxWneAqUDcoG7kDEX5o1GxuSnqlkJe//j
	0GpDCYm9dTj18S7bNj4SuGUVYWBv6XeTf0Yp4AuD4mTVI8LQK3tyk0FsLXL7ebf+FScv3KI8j9q
	aW1YbUluoS9OwUbJk8b7Fa0n23HMg86jNW2db5/Ajtp8vrcE1p/YhKVixgjqyhE1QA==
X-Received: by 2002:a05:600c:3541:b0:4a5:a5ca:de1d with SMTP id 5b1f17b1804b1-4a9675dc907mr75026265e9.30.1793212712626;
        Wed, 28 Oct 2026 11:38:32 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa80f04723sm10842695e9.5.2026.10.28.11.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 11:38:32 -0700 (PDT)
Date: Wed, 28 Oct 2026 18:38:30 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Reid Downing <skibletz@gmail.com>, Carlos Maiolino <cem@kernel.org>,
 linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org, "Darrick J . Wong"
 <djwong@kernel.org>, Eric Sandeen <sandeen@redhat.com>, Christoph Hellwig
 <hch@lst.de>, stable@vger.kernel.org
Subject: Re: [PATCH v2] xfs: fix wrong compat fields in
 xfs_ioctl32_bstat_copyin()
Message-ID: <20261028183831.055627aa@pumpkin>
In-Reply-To: <auISUBmIMQr7fesW@infradead.org>
References: <20261027161748.2760321-1-skibletz@gmail.com>
	<20261027164911.578ef6e7@pumpkin>
	<auISUBmIMQr7fesW@infradead.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 Oct 2026 08:18:40 -0700
Christoph Hellwig <hch@infradead.org> wrote:

> On Tue, Oct 27, 2026 at 04:49:11PM +0000, David Laight wrote:
> > On Tue, 27 Oct 2026 12:17:48 -0400
> > Reid Downing <skibletz@gmail.com> wrote:
> >   
> > > bs_blocks and bs_xflags were both read from bstat32->bs_size.
> > > Read each one from its own field instead.  
> > 
> > It would be much better to do a single copy_from_user() of the entire
> > compat structure and copy the fields to the standard one.  
> 
> Care to explain why it would be "much better" to do two copies instead of
> one?  The only benefits from copy_from/to_user over the current
> get_put/user is avoidind the conctant user access disabling/enabling,

That is a massive hit.
The current code also has all the conditionals from access_ok().

> but the scoped uaccess thing would do the same.

True, but unnecessarily 'technical' for this bit of code.
You also save all the exception table entries - so the code size
would be rather smaller.

David


