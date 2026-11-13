Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794602237;
	b=SzFjAo86jIZN6BhoTV07WjEIgMFst0Hdym/Zm5s2MIox3JLfw6Yu0PJh4Lzz6h7UzXfZ
	 VX1duh0pJy95IVsBTvl6Sq7XV3tKuAucT2T0u7flT0NUKYgNsCjz49/2UyHysbLiTBFOq
	 aq5Oq0OhUEug8daVEIqXAu2ieW2/LY5Gs0aCWv1Gu+X/Pg1D84BO/htOGXbjaxBYAP3ax
	 b5ffreGCGPr1VKWQ3mkektJjK3ThoZpdSNCAfLFfInXVQBu36wCRSSaChYABFFtSU3gU5
	 PJF9ouvKaIDq/TGaizop7YPN+BD0AdtGwe8yuKp4iiTgQJhTbJKIeLpzgbQP+rN/4Ww==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794602237;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=Q0zmMS95Y2iOsvCJTAiye2FTSJmpfdS8NTIq4CrS7fg=;
	b=Ch5l03uaQRRRMqIH+pNsYPHKbCOuCWhiH81zppY9eZZgowCjMrS95ZyR+1dsZd0q+3eL
	 rblgDwTBYpERrz3ENd02jppjzPdxOcF9KHFLfv2QNHKEy1vJXRvUvlpAM5K3mSccMX2NU
	 tkiZUNC3bk3BbwLi+DXhYaTyz8uYjoRKFwDJyUWkcM3KGZCSPrCE2bbYgxedEkx2Fb+zZ
	 TaqkiYcynRhII89w3KanAREE85p4tkIC/lPxW1JmB3ccBNrrIXl93l+RGRryyblsrrqIw
	 pCucD8PHAdCjmRiNZmdY7KZGSxZh8ojgBGVOdbDvAFfZS6AHIYdxBW+7cA0SDlwnbIw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ceb14J6a;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.49
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F22F606A330
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 20:37:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F22F606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ceb14J6a
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c4395d31228so296542866b.1
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 12:37:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794602236; cv=none;
        d=google.com; s=arc-20260327;
        b=JcmotgwrTcADdQrM0oMWWnqarJdGbnWIWWSG6nyN8UeDoxdm0ZW042DSUMsAT3Z6yj
         VbeUku2qyWXtsIysNPEDW5VrnT4jrAVSrJVcfVTq0caM2AeZz0elSYSNibAoz7cb2kCs
         iy83vgUxb3vW3Tg0xSvUrDLQuzIzH/BnA/xHQKTAXZb7uRx1QXstsosE6JZHG1AUNl32
         zBcuwrQjFOtvuIoUNSEQrlfM/egYpiBYr1pvX0Qr+JDAlPcRORKV16LAtCrj0DV/Pv8l
         5EZ/hZHZyCfQry4uqUFBXSf3n9TD6jgu6jO2xbIbLmcaBywH9dzFcyzo8B6RNQlZ17EA
         9ksA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Q0zmMS95Y2iOsvCJTAiye2FTSJmpfdS8NTIq4CrS7fg=;
        fh=DmgB5H6Rgfw/MWskLFs5SXQQFEzAS3zdXVGapKOOi30=;
        b=ZKVilmQ7PfT0INSmSRliSItKiT9if34SuMQTPr7JWabnp/mNJf9J2xBOsttRuL6bxu
         DIBqA5x69qJHF/XS7iZHxuOlhQezIDTApgI2xlKs/SyJiZ0eRP5UEqlugMoTG1A2SeOX
         Aee0/bD00Fx8yDSby7tK7JHONnu+sx9zXsttnW6prI7DlHGpDYtdUnLNg1o3Au3F4x5m
         xQkzjQLZeqI3YaME6QpqYHqdtNrreOffSnR0W8Fu0c32PW2VslSGraJzvrH3+CX79qMe
         cYfDiq0E7kzxlJNLpcRcnYLI8aI8FvrwjHM8FmYpzxBcDLfKTdEcFUstJVVzGt+pq5+f
         2pzQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794602236; x=1795207036; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q0zmMS95Y2iOsvCJTAiye2FTSJmpfdS8NTIq4CrS7fg=;
        b=ceb14J6aCiub8PwS3mQUNXCY86BMGZZQN0L1eWWeFCdjdbQZHzYli0Me/XBqFJklt9
         XX+If23LQbF5WHPiMWO8ua7VpEW7IhWILPW1GW9spI/dcCYFiMts30JmZND/SnlNFFH4
         S5SPkdaqTj5jyb7Fs7Da96CnEC4YLZ699XdNoh6D30NY4HloKgLGZr78cCGDsb5k4Vko
         sHZCrPg6/C58dnhlVfWwFyJamWaNhSJmmel16hhiMUjUPh3cynRPiusEyPn+IflD1z8s
         wDArTtpsxB8ee5rurZ4JN7V5z3m7nGPitzpVn1fcQUF4J4Ko1jIgJqxn8ug812tScxKG
         M8+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794602236; x=1795207036;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Q0zmMS95Y2iOsvCJTAiye2FTSJmpfdS8NTIq4CrS7fg=;
        b=RMVYRZjQDe+v0QAtDlkyLuGBW87yMb9pChoS3tXls67zMqX+GZlVMflW1q24q2MUyS
         fX+HRJhPU88rZNa2p4FLzahRSx9PTXaN0LzrTs8ZRdGQo6JigWbHTmaDJk7r4BmghwN3
         +olLK6uf6uqHdLsAsZeIPVJOaxiUYEmN6DwgsDimbo99ew59UHGar4qJ5tyQdkdMdvhs
         OkgJhoxkrOWKNqIF7rTpQbld/ll2s7BqnhqgrHDNu2SQvkGCU40Q8ScX3md5RKeSTaox
         7f46jD/U2oKsBllkR5eD3qtgH6MXOYb9Fn9NEukr4z8TLGoPBsaQivL8HT5sY6V4Kmkh
         VlZg==
X-Forwarded-Encrypted: i=1; AL+hErFFQ2mR3L0Bl0+wfmTRl6O6NpNHt76OMzvlc9ZKysv0hj1xJx95+cC0ZX1FhATivZ98EiZxBsE=@vger.kernel.org
X-Gm-Message-State: APuU4Z9g1gT4AW35BDOSozBfja8IznBnPED7PB5IkVCA3Nx3YiBsM3vY
	NaJRCAVpJ/NNy5yizwEVyz6gpqF1I1VxSzb9n6Xiseykb/h4s4e4Ee4JHdsb/WdIMPMsutAaBaW
	5mMCOPWYenZ5d9MGdODsJ/qpEddsFySBT0Xi8IGrX
X-Gm-Gg: AYBFou12wRIhX0pTnEY+YjLWMCKN36MzLArGeQ2FzN4fAH2zE40gvE92bSZ3tfnA9sw
	W/9z1KYK2gK8byZOYylXXUx0St1mxclVNw4EF5CE2wVr76GAsYzVYgLHdxYd269UcV/XohMn5Z8
	D1W81sbjv3rGxKAQ60CEs9bkIrMXmzX0LxPhOhl2cg0bWbZIb+MB/5+RnD86BYiTJWL4X8ldlob
	i1MVr21UK3sK+lNAukLjDdWNHqYr++xsXX0Gt+iSpkFVbgZmzLurKuBbQdg2jC9QV3pc3dLyzR9
	pF3j9hcAoK6ZptFTdZfBgA30ZdKEwgOzRfVdrcNp+La2f37es8MIy/gZ0jRKtYAHtWMNOOVbYuj
	xN95335Oq2NANvjRN2Hl3hJdt6IIpQ1OKWmz/Cg==
X-Received: by 2002:a17:906:c14e:b0:c3f:c878:7c1d with SMTP id
 a640c23a62f3a-c5096307650mr316429966b.9.1794602235243; Fri, 13 Nov 2026
 12:37:15 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261113195553.2220562-1-joshwash@google.com>
In-Reply-To: <20261113195553.2220562-1-joshwash@google.com>
From: Joshua Washington <joshwash@google.com>
Date: Fri, 13 Nov 2026 12:37:03 -0800
X-Gm-Features: AclHuK9ptA2Q7NDGZ-JiCdfTID2_a3zpW-s80Ltd9yW31n9tVs_J6wRqHrbt7_I
Message-ID: <CALuQH+XPebJ67K9ntdYoruXdLH0tSt7EFkesfd_=3ATNJiQBwQ@mail.gmail.com>
Subject: Re: [PATCH net] gve: fix checksum state and gso_segs of HW-GRO packets
To: netdev@vger.kernel.org
Cc: Harshitha Ramamurthy <hramamurthy@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jordan Rhee <jordanrhee@google.com>, 
	Ankit Garg <nktgrg@google.com>, Tim Hostetler <thostet@google.com>, 
	Willem de Bruijn <willemb@google.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Praveen Kaligineedi <pkaligineedi@google.com>
Content-Type: text/plain; charset="UTF-8"

This patch is missing my signoff. I will respin, adding the singoff
and removing the reviewed-by, after the 24 hour period.

-- Josh
