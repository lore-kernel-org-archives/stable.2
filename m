Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.159.188.251
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792849651;
	b=yRQ6K1+0IQSsmHuOOcjpAg09nRfI4lFziCocCmnFuC172rpEVKvbnZMCaXa0mnPphh3l
	 zINnXgvdUPM3Z+cEX5c+s/LfQlnEhCOwJ4JfIltiJrut27yKlrhZjqDJL3cKVKf4Zeb64
	 1yRyQytnOxOImwlGW43fAiKPUB7g0nvgOKIuTzmIk4s3nWXNWekEpW3pz7Q29Fhtua7H/
	 5i+zvrKyN1FF0JO38m/01PyvLEJn2Vsb4ji3XSp18l2VLbiOajDhJD65t7uWz/d+jl8uu
	 BoDeg0giJ+UgacKpjsn8TvIRKa3yRzP9m0PJkvmzFc53ynBkLlH7PJ15Y79W4AZWURg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792849651;
	h=DMARC-Filter:DKIM-Signature:Received:MIME-Version:Date:From:To:Cc:
	 Subject:In-Reply-To:References:User-Agent:Message-ID:X-Sender:
	 Content-Type:Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-Get-Message-Sender-Via:
	 X-Authenticated-Sender:X-Source:X-Source-Args:X-Source-Dir;
	bh=pPBs3xrtR4T4D2lWZ+67aGijmLWPIIJarhkwTdzpy/Q=;
	b=S8/cEspZUHcAg8IMB5q5WTj+VaVNyshRvf8LoU6ivisei8jAOPH2cUgQ8B1qGILlg+aC
	 RIYuWQAJ/E9GBiXO4WFb2dd4iIN0jtQwjdtBzHPHTywOwr10dGvWc9RI/phJsIum0U4Rn
	 aJ0uFvX5Iio2eMWywfA43mmEwKlT53r1ppvaeSD0Grq8EXBX2WHIxYqIRWuZQ98W5gKBc
	 Q55fpC+yBf4Huj8upDeKUR739UYeo5S6b2l6P0kzVOizdkF6C6nHsJ9g0b/Xrj0ZU0tYa
	 bpwMgKmdAAJ7V8fEOzMN796L8vVbUWk0WqxI3YYisyzwv/4NuvULM/6FiDW30XjjC9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.cyber.gouv.fr;
	spf=pass smtp.mailfrom=oss.cyber.gouv.fr;
	dkim=pass header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=XckZgYqe;
	arc=none smtp.remote-ip=51.159.188.251
Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0A7606A31A;
	Sat, 24 Oct 2026 13:47:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D0A7606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=XckZgYqe
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:
	Reply-To:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=pPBs3xrtR4T4D2lWZ+67aGijmLWPIIJarhkwTdzpy/Q=; b=XckZgYqej/AwwA83bB9G8PSH8x
	B2irdoMwfyhmxTydy72C3bwWvlya4vdOtsW5NOMwDjpN0TXSJgdwLUtPlF59EaBtT/a2uVZJ7/1Lv
	ro9wxK75mPN7h51h1xW+zyzf8B63+DuHdy4Lsgnrlf4fBbxcehLOy40dVVld7Dvk5s4xgjWD3xyVu
	/gql9qemQwUvlvOyPbu2X0eQtrYmctNApiEn2EXCUiz2gWCbH1Wztzi/l3gbOTl9ABWJXeKiW13qp
	30avuO1Xgcr6uwizJ/ilGG1aOc7IwJolyjMGlk+qdR+RS3HuCESWZUCWBBMV7ap88I9XtL2NBi+HR
	j0VR2wcA==;
Received: from [::1] (port=52414 helo=pf-012.whm.fr-par.scw.cloud)
	by pf-012.whm.fr-par.scw.cloud with esmtpa (Exim 4.100.1)
	(envelope-from <jeremy.jean@oss.cyber.gouv.fr>)
	id 1xKc5q-00000004iKa-2P5N;
	Sat, 24 Oct 2026 15:47:28 +0200
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Sat, 24 Oct 2026 15:47:27 +0200
From: =?UTF-8?Q?J=C3=A9r=C3=A9my_Jean?= <jeremy.jean@oss.cyber.gouv.fr>
To: =?UTF-8?Q?J=C3=A9r=C3=A9my_Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
Cc: Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu
 <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
 Eric Snowberg <eric.snowberg@oracle.com>, linux-integrity@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v4 1/2] ima: discard modsig when detached data cannot be
 supplied
In-Reply-To: <20261024093918.2929374-2-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20261024093918.2929374-1-Jeremy.Jean@oss.cyber.gouv.fr>
 <20261024093918.2929374-2-Jeremy.Jean@oss.cyber.gouv.fr>
User-Agent: Roundcube Webmail/1.6.19
Message-ID: <b7b59b3fb2f0977808ecf5bd32970782@oss.cyber.gouv.fr>
X-Sender: jeremy.jean@oss.cyber.gouv.fr
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: jeremy.jean@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: jeremy.jean@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

On 2026-10-24 11:39, Jérémy Jean wrote:
> ima_collect_modsig() supplies the file contents to the parsed PKCS#7
> message as detached data. If the message already contains embedded 
> data,
> pkcs7_supply_detached_data() returns -EINVAL, but IMA ignores the 
> error.
> ima_modsig_verify() then verifies the embedded data instead of the file
> being appraised.
> 
> Make ima_collect_modsig() report whether the file data was supplied,
> and discard the modsig if it was not.
> 
> Fixes: 15588227e086 ("ima: Collect modsig")

The public instance of Sashiko raised some relevant feedbacks for 1/2
that my local Sashiko run did not see.
I will address them in a new version.

Regards,
Jérémy
