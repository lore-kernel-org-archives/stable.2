Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794933867;
	b=aKXtM73Tf62lerK9MYnTO+WdeMD6Z0F0jx/R1zRXDYQQm+4txhYQFgFu1wxOOvZ1DxjW
	 9hlUE/X+Jlhfi3g1UbKYqc1JBdwLJecOWh8QJgfvcHiN0vnzgNSKhoJ5oRFhzpVAXBtEp
	 GmtHNqFcCj+cmEBQuhhCUD2Zk6HBOnNUfvwaWon+q44leSVQdLCRt2Cfz2JjmpcGazqe8
	 frExBHktZbKHFF7/ys+F504S3nbIK9pJvxVoUlpz0xkVAYa3wjruA5HP0cJFeTXj6mrTv
	 3CkqK+2Y8nbTEHM0nTBpW3JQxPTsl6noIeFINtOtBA4suJiVI+bRFsDNVADkb4zKHCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794933867;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=50vjl9YBE66T7lj1HBlqK2opc1YN0lcdlSAPe79oVN4=;
	b=gtpsZE5wBtFiGjB2kzQQHqQ5NmjqKPy15N9Jl+0fLlR5KxeNkaEroZx7O4vUJaW7o1Sv
	 EJ/cMDqPaNbh2Kevqw/DoxY3tFk20R/VI4iN17yBsPQln4GEzfNQHl472UeFhOmODVa3i
	 pH+vMzOI0sf+pmsWimhhvviiqikKZcqhxRq/xWD3xAqAS3zvIq4TVsIU0QT+P8KuigMhO
	 icx5iz7q+HLscBDTVtjb4j4x1aod5vFEsHBXCiohT8p3LE3FGBZwY0+ZyS8Po6d7auYzm
	 CqdDe6g9yatQr8lslCGbEw3OfXvY7BKh1oY+En2hvR+sga3a+0gQbXi21L789b5p0Ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=SnlMuzxZ;
	arc=none smtp.remote-ip=209.85.218.48
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C21606A31C
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 16:44:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0C21606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=SnlMuzxZ
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c40f29667e6so862580866b.0
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 08:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1794933865; x=1795538665; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=50vjl9YBE66T7lj1HBlqK2opc1YN0lcdlSAPe79oVN4=;
        b=SnlMuzxZh4VfuZWh6kz2B5O3Ua3a933UaiFL8Dz8SyFzR/MgkyDq6xzYAuD09bdUX4
         q6THxcLkgjSD2prJn42xdZTNWM7jy5ZvlAun+ci8P/opXJ6cuYF2i6T9xGorKldQYC6V
         WGy9OsgLAz+/HwVu+LRxrogHRlvM478t1vO7s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794933865; x=1795538665;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=50vjl9YBE66T7lj1HBlqK2opc1YN0lcdlSAPe79oVN4=;
        b=i2lU+Bvq0mtDd1EVs8n1APhD2Gi0PFuolXCz3WaDy6u+pXKcrmCB51/wQn8Q/1vZsY
         fDiFIQFdUEZXSiRIP50cxAqyCYnORMkRG/CH7qJYCzdGysH6qKQtcWPufNkGUuPnDrb8
         qFIpnvv3M+9GhGpHraKAg4tATHFWV0xPhrMDSiLZb6zddlnUk5TohrtY86BxQgySQcT4
         YvvvtIwJNdInk+VkE7h4hBS1Sb9Il7Jc5LjTu+dTvFduCODNTOVMBNIZHQblvKIHkRMj
         VxCzgVsYv4UK7y/vhORu75BoFcJDdsyWw2ZtvDZEEhxokgH2JyXyyu0v0mwqb5CCWS4F
         micQ==
X-Gm-Message-State: APuU4Z8lWLrv5ZcTGLsm2kL6E2ifBiHRr3VVovhi+GoBrVPMJMC1QdoM
	kSEe1rfZpgTpXCAkVkBKmUBHpaKPqLVTxQnUVoDWbjbp+8VUPPRpTB/Pr0OMSvBjmJ+lhJMqj/u
	U8ytz/lu0fQ==
X-Gm-Gg: AYBFou15ITh5z5IEldT3Skv0grfCDrlS3q2kjoPljI8YPUQBK+nvzRP976EfaJKJOS5
	YAjFtQERvE/txMfhuYVpe9Y83ptQqBeA9q9ySq07P+Y/V4oVZ3R7WFSkY8xAq1DGj7HYG73SyxT
	YMQ3fEtXk4mRHoChprm5v47+YU9lcPJSOSF3hTaoe4b1ODzYUKE6MfI3KQc6mA8ISXYYkUxP+wM
	o4AauDwIdi79aBHrOgXuncuhxG01KyyyYb4yT21Lcr/Yy5gO+SaSM/n5aBUfWURHt/gVO3L7O8t
	U/Hjz3MQbzfrPXeFKlxGjy8MYrnZG8I0QOvXbV5WRw3iPv/cRXQQcFGnH4EjXgUWgVAqO/V0yhO
	2I8pAnIIM9W7QaiXBObcZykL9VWNMkAdQGS7tJwgjU0JSKRjquIBx3iIGQrSuDYZMJtQbEIT8Ls
	CEhaSOqjAb+2S9huor0gX0hNA+hfjTfpXjoirORqlGtT57D8PpaFSAs0Qn8eyFZXiFDTE3ajpEf
	EZ8zoa7qHyApiW9XiCDyqh385jS+desDYBE5EiJQCVyt0bPcCIX30xZqc4ZtPYkiWxF13FqOEjT
	XmBoCYBRBtxrx0r3seycHrfSU//mVIBchR3+HrsLTsJvxaufG5Jo4PHpNPsAolZrx8XHlAs0OjN
	NOsY=
X-Received: by 2002:a17:907:9609:b0:c51:638:7838 with SMTP id a640c23a62f3a-c510638795cmr156647166b.33.1794933864483;
        Tue, 17 Nov 2026 08:44:24 -0800 (PST)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c510cab3000sm3040866b.56.2026.11.17.08.44.24
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2026 08:44:24 -0800 (PST)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c247f6687dcso855275266b.2
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 08:44:24 -0800 (PST)
X-Received: by 2002:a17:907:3f88:b0:c3f:153a:865f with SMTP id
 a640c23a62f3a-c509643ad99mr1256401466b.40.1794933859001; Tue, 17 Nov 2026
 08:44:19 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117162917.1995578-1-sashal@kernel.org>
In-Reply-To: <20261117162917.1995578-1-sashal@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 17 Nov 2026 08:44:02 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjJ80Ajzu6vd6TOjaV1jSVgvBJ04nMT0qK3igvqgu_Oxg@mail.gmail.com>
X-Gm-Features: AclHuK84ySXrkusJ_FYpHt2_yWmDfNJ_gb_Catm6HC7iJGneVbaJvw33-ejJBsc
Message-ID: <CAHk-=wjJ80Ajzu6vd6TOjaV1jSVgvBJ04nMT0qK3igvqgu_Oxg@mail.gmail.com>
Subject: Re: Patch "vhost: vringh: use get_user()/put_user() for IOTLB 16-bit
 accesses" has been added to the 6.18-stable tree
To: stable@vger.kernel.org
Cc: stable-commits@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowangio@gmail.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 17 Nov 2026 at 08:29, Sasha Levin <sashal@kernel.org> wrote:
>
>     vhost: vringh: use get_user()/put_user() for IOTLB 16-bit accesses
>
>     [ Upstream commit 95a214f31a3b1ef40034f1e1cb3b9d758a374f01 ]
>
>     getu16_iotlb() and putu16_iotlb() use __get_user() and __put_user() when
>     the IOTLB maps to user virtual addresses.  Nothing nearby checks the
>     translated address: that relies on the mapping having been validated
>     against the user's VMAs when it was set up.
>
>     Use get_user() and put_user(), which do the same single, untorn access
>     and also check the address.  The only atomic-context use, the vdpa
>     simulators' notification check, now disables page faults around it, so
>     the might_fault() in the checked accessors stays quiet there.

Note that the "now disables page faults around it" is not true in
stable kernels unless you also take the previous commit:

  05fb07c40e00 ("vdpa_sim: disable page faults around
vringh_need_notify_iotlb()")

and I didn't see that being sent out, so it looks like you didn't (but
I didn't check your queues, I only looked at my own inbox, which is
the same disaster area it always is)

               Linus
