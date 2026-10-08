Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9374E47F2F8;
	Thu,  8 Oct 2026 09:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791450232; cv=none; b=uDdShGwUuHXP+Qz6tlavl4SU27oOVdD9vV0OeOjbj2qVhYmpZrbjqeAa7RkD3B0bDXibclTd1b6GoONZ0HRXlfjexRxePbC87hr4RJjtkgv/creWlJdplSXRzCRLSa2sUadPKNi1S8VlsREH1+nhE0EfIZhs4gDW3F7oNeUvK4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791450232; c=relaxed/simple;
	bh=j6pSGeC1MTs7/YddTI+AU/X+Y599J5vImXbUeyZlGkg=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Xh+Vy4kNdsk/R5WqmMniAukTTgi0ah6QPyYBXFzhwb88j5w2kiNg7bq/M2zGAmyTzdaTmubo0dsLJ8BQoOE1xyA9rVHb7Sr5w+XEw8ZBT90+4qG/lOwAXUdPoth3cWW/7jiMB0Kh98+LjqYIGyaXB3ZNfNTnKmfW9My0dGlAHwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=j7PDxMYR; arc=none smtp.client-ip=51.159.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="j7PDxMYR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:
	Reply-To:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=0vXi5kAmq0ktXNfJ32duwtCOreHH5Rg+dCEdNRfBLi4=; b=j7PDxMYR6urzqEAbV4dlCqZenP
	xDiB+Td+MaUXvUQLMp7m1SrSnaKViCe8na81FdSHxCnjx7BG2oc3zhUfk7RqpdWfaIfrHl/15IycI
	C/uyz64txrPxwXMms6NDhzk/2VDoPRr8RPFSBJ5C0wEwAAprXseTXwMw0rtSk/P9u2IBjd+XaVUcu
	S880hTd4wYREGnuhAlCbGYNJoXF58iyh/ue5Zntx5iEe7CqhyadpMltCwwC2JQvcrtyI2lURHuVwU
	QBLwaZSljDi8UPsk10lzP32bSmd76OdYTTVb3ds/kiE2FHAjB1XxsJXJxIr/irwAUMuNITd8uCGSq
	BlXkM66Q==;
Received: from [::1] (port=53148 helo=pf-012.whm.fr-par.scw.cloud)
	by pf-012.whm.fr-par.scw.cloud with esmtpa (Exim 4.100.1)
	(envelope-from <jeremy.jean@oss.cyber.gouv.fr>)
	id 1xEk2Q-00000002Mkl-1DKP;
	Thu, 08 Oct 2026 11:03:42 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 08 Oct 2026 11:03:42 +0200
From: =?UTF-8?Q?J=C3=A9r=C3=A9my_Jean?= <jeremy.jean@oss.cyber.gouv.fr>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] net/sched: fix use-after-free in __tcf_action_put()
In-Reply-To: <20261007173503.588b9c7f@kernel.org>
References: <20260930211839.620410-2-Jeremy.Jean@oss.cyber.gouv.fr>
 <20261007173503.588b9c7f@kernel.org>
User-Agent: Roundcube Webmail/1.6.19
Message-ID: <776ed0c422ace98fd907468f78ea9cb0@oss.cyber.gouv.fr>
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

On 2026-10-08 02:35, Jakub Kicinski wrote:
> On Wed, 30 Sep 2026 21:18:40 +0000 Jérémy Jean wrote:
>>  {
>>  	struct tcf_idrinfo *idrinfo = p->idrinfo;
>> 
>> -	if (refcount_dec_and_mutex_lock(&p->tcfa_refcnt, &idrinfo->lock)) {
>> -		if (bind)
>> -			atomic_dec(&p->tcfa_bindcnt);
>> -		idr_remove(&idrinfo->action_idr, p->tcfa_index);
>> +	mutex_lock(&idrinfo->lock);
>> +	if (bind)
>> +		atomic_dec(&p->tcfa_bindcnt);
>> +	if (!refcount_dec_and_test(&p->tcfa_refcnt)) {
>>  		mutex_unlock(&idrinfo->lock);
>> -
>> -		tcf_action_cleanup(p);
>> -		return 1;
>> +		return 0;
>>  	}
>> 
>> -	if (bind)
>> -		atomic_dec(&p->tcfa_bindcnt);
>> +	idr_remove(&idrinfo->action_idr, p->tcfa_index);
>> +	mutex_unlock(&idrinfo->lock);
>> 
>> -	return 0;
>> +	tcf_action_cleanup(p);
>> +	return 1;
>>  }
> 
> Why did you decide to invert the condition?
> If nothing else the diff would be more readable without that

Indeed, you are right: there was no specific reason for the inversion.
Below is a new fix suggestion.
If you agree with it, I could send it as a v2.

Regards,
Jérémy

diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index e45a63be397c..9eb1dec14cb1 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -372,9 +372,10 @@ static int __tcf_action_put(struct tc_action *p, 
bool bind)
  {
         struct tcf_idrinfo *idrinfo = p->idrinfo;

-       if (refcount_dec_and_mutex_lock(&p->tcfa_refcnt, 
&idrinfo->lock)) {
-               if (bind)
-                       atomic_dec(&p->tcfa_bindcnt);
+       mutex_lock(&idrinfo->lock);
+       if (bind)
+               atomic_dec(&p->tcfa_bindcnt);
+       if (refcount_dec_and_test(&p->tcfa_refcnt)) {
                 idr_remove(&idrinfo->action_idr, p->tcfa_index);
                 mutex_unlock(&idrinfo->lock);

@@ -382,9 +383,7 @@ static int __tcf_action_put(struct tc_action *p, 
bool bind)
                 return 1;
         }

-       if (bind)
-               atomic_dec(&p->tcfa_bindcnt);
-
+       mutex_unlock(&idrinfo->lock);
         return 0;
  }
