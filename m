Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F4A559CBE
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 15:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790090813; cv=none; b=GlmLgB3Uu3NvGsSCReF3ZGSJStsMafwyuntoLkKk4/3Fa9uoGfI0trnv6TKggoXp4dmuHAPmZhXHAWAhH0GV4rKRS++VQovJg2kXBcnbHzOLBqDY56exReUyU0JL3iwHg+x0vtQEc2EbOD4cE5wP9NwTOjh1OmIK/n4JRDhYIpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790090813; c=relaxed/simple;
	bh=Nfpo/PElH+hUuXM1DSN+liBKZMn7dhMb01zv1lmNiYo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dVn1wmgOeiKm//Kyw03TVCOaWJNeJOIBxy+t4/gr/57ddgKmwWTgB9KlXUzRTLOUZ8Lfd9lQmizRTinFf4xrUUZgGewLHIW0XIU5yq1+LKci2TY3N4vSRxa1p71zDBg3OGq7uoRkwxwjCfvhsW0zlFq6r2xlhDKD/2czxN82Ea0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JqI68iqg; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=oXaaBbG7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JqI68iqg";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="oXaaBbG7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790090811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8HgF1fYWmdweGa6Ay1VNB6tjKEcFrxVON/LrrH3c8qA=;
	b=JqI68iqgF+zS4G2qrlW8d/0CADhMsqpRQZsOdrAnBgiyiDkvsl0jFR0/V/3Wm4cwKoEYk8
	n9lZOAZLJG/s/9mg7qhCKp7HW0scuAAkofgfwvur56/oJo1mNZgKRKaLeAmRj12vleSqFb
	sTKqcSIJDCGcZALZI2+KA8rfwu7l8/g=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-22nNKTIFMuqQycgaMjbanQ-1; Tue, 22 Sep 2026 11:26:49 -0400
X-MC-Unique: 22nNKTIFMuqQycgaMjbanQ-1
X-Mimecast-MFC-AGG-ID: 22nNKTIFMuqQycgaMjbanQ_1790090809
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49e76a80fe5so59533405e9.2
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 08:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790090808; x=1790695608; darn=vger.kernel.org;
        h=content-type:mime-version:user-agent:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8HgF1fYWmdweGa6Ay1VNB6tjKEcFrxVON/LrrH3c8qA=;
        b=oXaaBbG7WAP9r1MbYOMcGTNVKChT1lAE7nadpflx1TcbKnUgT5XTwW62XVrNHXHaAc
         AF6QoVlv+IKaXiGx7KQLEmCUlJU2XvLT6uialFii+WzEFLq5hHb2L8nx1Qzx6ZA0GdTg
         rLAiDIsHLCqtuQ3+nqP7sCi17oDsDSim7K9CIPVVOx5KQiPoLJYqR5t+VFCt+jYAG3DH
         auU+ELt/hMQJjraTCkBCJcqZ0Ug1iIyZR38BoIgVes0srr9YPJ02lXAE6spJthIzmPmt
         Pqzf/GT0SfuII4XAIj0FGsA7kG8J4LryHESJDYorkNk7zrzieRv44zlz4CHE4v+O8eP2
         e+xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790090808; x=1790695608;
        h=content-type:mime-version:user-agent:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=8HgF1fYWmdweGa6Ay1VNB6tjKEcFrxVON/LrrH3c8qA=;
        b=rB2cV2YqGQ9U4szSpdYGZGtZFYqavGpO/I8Ox0QbaE+RcgUXELLnEXtrez5MqNSCXI
         hiqm9uUwwIR9d3JSrJ67NqoSwgiS8YuGdSmjLtf3FZwYDlsdYVPEnVYS0kIvHitQ3xby
         TWzr6SqWBszOsPxy5BWkF5ClcwjLQL8OrGiW34PFshYMHzxb9gDWK6/TIYVNhMaj7ob7
         rqTimQRJpQrFMInALBnDbLvLTLNNIAZ9EklrnOG6Qh4iw8bClaHepevqpznjFc5j2/B2
         MUNU0sa9e0o5U65MJMfSBK+Xr9G0j1kxMJfxxV0uOVlZb8upQ5Eyp1lW/QdBC63kTekV
         VDpw==
X-Forwarded-Encrypted: i=1; AKwUvBw4ihxuzvNluXrd+Fp99fyZpcffjobCix+dAY5QHjBbA4WI0ePTfHa4cOXYY5+KorBkN+x4c1Q=@vger.kernel.org
X-Gm-Message-State: AFuF++nJe82ZlMIF5vJDMYdsNyUmrqm+WZQ08bUeHWCFMSmhyz+TSkZU
	v6VmejqiM8aR6uQZuIfFuaGsuf+2SfAIe1FvpYLNXCQMVJ9IKBM+qAj9aFkkENNiTuhc+pUh89i
	6fyHd7qKo2FmGf18y5bW5cXX05NpEns7RZtaTbS7qg9AB7kqID5Oxsn02gsh6mYB4Ahm3ltvjuX
	b0VyU16850iQpZX520VZHXoLaLcGZvEhwamfyh2b65zx8=
X-Gm-Gg: AYBFou01l6hjsLqmOolqMdrFJMOb4CoPk/nf1UQ02iyJUx+fuvfKQmWhUFUh4DOzw3H
	BE0cHFZJobNuJEPjNny3QKH4rkdSuF9UrWsH8v/kbtZem/oTXnIRQXtDvMLpXBGMTR1Y/5apyd5
	2afX0NYPmRN6HLoEne8jDkVDmjP45yEVVoq+zw/MlRNmw9zEfRxfPzjxbCflLWe9ZAOOSX7/20c
	uz4hth8OzqrUGfUaZhgrZo+zrdF7q4qX+U2qPKwbg3fGgJIkIcHNBuRD/2Rs9zfw4rywDBBwzAx
	y7V6Na4zqGuXK5IS9J1dAyNN+rsuFlHgWcBbSHy+4jq4bAjlbrlcsVdxrg8Wxc4N10bTAmXSa0f
	q19AI8tzrBl12nuAGzd7r0oIV2MPX
X-Received: by 2002:a05:600c:310e:b0:49c:f4ff:e872 with SMTP id 5b1f17b1804b1-49fc5681249mr210658515e9.5.1790090808490;
        Tue, 22 Sep 2026 08:26:48 -0700 (PDT)
X-Received: by 2002:a05:600c:310e:b0:49c:f4ff:e872 with SMTP id 5b1f17b1804b1-49fc5681249mr210657815e9.5.1790090807714;
        Tue, 22 Sep 2026 08:26:47 -0700 (PDT)
Received: from aconole-thinkpadt14gen4.rmtusnh.csb ([216.212.25.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fde071f85sm875605e9.4.2026.09.22.08.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 08:26:47 -0700 (PDT)
From: Aaron Conole <aconole@redhat.com>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org,  Pablo Neira Ayuso <pablo@netfilter.org>,
  Florian Westphal <fw@strlen.de>,  Phil Sutter <phil@nwl.cc>,  "David S.
 Miller" <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,  Simon
 Horman <horms@kernel.org>,  Eelco Chaudron <echaudro@redhat.com>,  Jamal
 Hadi Salim <jhs@mojatatu.com>,  Jiri Pirko <jiri@resnulli.us>,  Xin Long
 <lucien.xin@gmail.com>,  Marcelo Ricardo Leitner
 <marcelo.leitner@gmail.com>,  netfilter-devel@vger.kernel.org,
  coreteam@netfilter.org,  linux-kernel@vger.kernel.org,
  dev@openvswitch.org,  stable@vger.kernel.org
Subject: Re: [PATCH net 2/6] net: openvswitch: conntrack: remove
 'add_helper' dead code
In-Reply-To: <20260921145655.3167436-3-i.maximets@ovn.org> (Ilya Maximets's
	message of "Mon, 21 Sep 2026 16:55:44 +0200")
References: <20260921145655.3167436-1-i.maximets@ovn.org>
	<20260921145655.3167436-3-i.maximets@ovn.org>
Date: Tue, 22 Sep 2026 11:26:43 -0400
Message-ID: <f7tcxu5b93g.fsf@aconole-thinkpadt14gen4.rmtusnh.csb>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ilya Maximets <i.maximets@ovn.org> writes:

> This variable can only become 'true' when the connection is not
> confirmed, but it is only checked when it is confirmed.  So, it can be
> treated as being always false and just removed.
>
> Fixes: 3c1860543fcc ("openvswitch: add nf_ct_is_confirmed check before
> assigning the helper")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
> ---
> @@ -821,13 +818,10 @@ static int __ovs_ct_lookup(struct net *net, struct sw_flow_key *key,
>  		}
>  
>  		/* Call the helper only if:
> -		 * - nf_conntrack_in() was executed above ("!cached") or a
> -		 *   helper was just attached ("add_helper") for a confirmed
> -		 *   connection, or
> +		 * - nf_conntrack_in() was executed above ("!cached"), or
>  		 * - When committing an unconfirmed connection.
>  		 */
> -		if ((nf_ct_is_confirmed(ct) ? !cached || add_helper :
> -					      info->commit)) {
> +		if ((nf_ct_is_confirmed(ct) ? !cached : info->commit)) {

This is already a good reason to apply - the existing construct wasn't
particularly friendly.  And the follow up in 3/6 is perfect.

>  			int err = nf_ct_helper(skb, ct, ctinfo, info->family);
>  
>  			err = verdict_to_errno(err);

Reviewed-by: Aaron Conole <aconole@redhat.com>

