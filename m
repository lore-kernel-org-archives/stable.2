Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053B155C1C0
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 15:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790090798; cv=none; b=dngb3WHUELIuPZCSzvXq4Z75Yz758cYKriuZ9GtOK9JIgKoPEjX1gF1Mf+uWlazc3L8Sb+EJ4n5Mb7YWeWAtjdyATXGIqcEZSr6w+nEC38w+LpqFYqjPLXdcpc+KfrQi4aVv9D7uGMQcDr6aO1dmS7u3635XWwlq4VGE0G2vYfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790090798; c=relaxed/simple;
	bh=4tTfIyxQFrJO0eYjaziEFGFnUgNWltKT23dBmntSrLc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FKb8Cl298J6fW4ivJMvlJGxSViDyMUokaAqglQQUFFl3Wi7btjcBBPwironxNa9hLHcLAYx/m/9ts4doI8NZWXWzaR1PawjTtC943jVioF7Nyjr/njuXCy8yNv5I59FBtY6mgGNC6XYAA5kjg+Y88aMpsRjpZgzR8E1bfE17+J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a7mao0lK; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dg5AaW+c; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a7mao0lK";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dg5AaW+c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790090796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/8zY26QjQrdL1DZs1bTzu+yz0u+JYpgALxi7/8nmtuE=;
	b=a7mao0lKt+TWvY6OEuWnVs5xsX+/n+/UIkqV3UvzsLwllL0TYHW9PfGNyZhWUTla+kN3sQ
	mPjM4UW/uVwakGuXvJ4zPF7ca2p9sMNW8R7uWbAIxy+khQunINJMnXqkwWOXUKZHqGnEEG
	x5WryQmHGPtgUpsmQC2agLHHUNPtabM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-c-CcBqMNNGG297zggDlECA-1; Tue, 22 Sep 2026 11:26:31 -0400
X-MC-Unique: c-CcBqMNNGG297zggDlECA-1
X-Mimecast-MFC-AGG-ID: c-CcBqMNNGG297zggDlECA_1790090790
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49cf9df1eadso37942025e9.3
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 08:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790090790; x=1790695590; darn=vger.kernel.org;
        h=content-type:mime-version:user-agent:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/8zY26QjQrdL1DZs1bTzu+yz0u+JYpgALxi7/8nmtuE=;
        b=Dg5AaW+cXOG3UCb117mUsmYWky0JYfwjukmhT5YrjX0uSYZufp9ySioGC6uY/T2kFb
         DpFVJGLVdmi06uE8stG2Ld/0ga5sLnuqZCErQAXV2UMz4EX59Au2kG1kY+OURt02g3V5
         Dek6VhkxEUsIsQFMXMVZ+Ae1ee5PUoq23nqvDKc/0xaY3LVDtHV30QzfctbT+BiVVrJx
         ua9/l6ZshDdrYI5msQrOyhR9hR/v+vzBIW1rSKIO/yGC6kkzjMc7W59F9SnM3utVpkcD
         QV4j61mq0upYvBhGfDGjeclKE5nMQWMyytTTZCzlqSmX+sW7hFUhR5xnWWU5FtJGwWd4
         79nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790090790; x=1790695590;
        h=content-type:mime-version:user-agent:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=/8zY26QjQrdL1DZs1bTzu+yz0u+JYpgALxi7/8nmtuE=;
        b=n+krm25iH95MFaHi0oit85sMq3NI4WS/XsVktmVEp0+7m+x5mLyVH1a8exmpkKC8ZI
         yw/wK3YDRaKFCIJ47c2v8IicY/sNeNWCWeVrLt1EFIv1KPdH8brQWrV2T4wZhsf8A3I8
         oR7wp2UBnkoGJuAp5f74YS/DE/qghs0H6S5qqfVwptmwejtv+G+UQ0aZplHAcVsInd1F
         1JC19mnjsPhsek4qYg8krTAeAGagsAfHbs66216x4pzbrJ5BGgvLGg/kefRONPstSr+l
         uh8LY8Gwhbo3i89U2mljy3G2ObCdXBIiYa7unVAdnohSp3DUBaP3RjVtfSk0CGNMJhvz
         Kbjg==
X-Forwarded-Encrypted: i=1; AKwUvByA0i2UT6dtlCcYCm6KSCXYOX+xbcF82rnBtI5ukh0Gc59acFOMSFvDcmC9jz6VLn/q0fzqbjU=@vger.kernel.org
X-Gm-Message-State: AFuF++mWW2Ll/JiecWEUmIM7ywd/WSBSByq0ZzHPugQIXcChbOAP04nI
	EYHipHemNdaITgmtFFF4I0Vdqimd587yKrXSnqiXAtGmHDxVPqNvwzB3w4FXOpcS21iKrwaZeXn
	tGcjW/A3Rj86/ZpIJJxe2LUARkf5/tWz+qQjd75C70KjVEtSXkaV6hPHjRA==
X-Gm-Gg: AYBFou1afuPOec3gPBN0i7q+uqYaloHDDVwscI6iMBw63eG8dzz6aLj8rFz7fR1vhWE
	SxMDRxZrjCix0MrvSQ3ZGasX6njKgXd0XLRs2+brO0WLaaM+vInO/IIR/1DvzaDx//8aiodPnqa
	isRP5lW7wcFvEsd87Mq2wvoNz4gyD5jNUmk1H3pfX3He1CRl8CYYIszTmrKVp+1fk0ljABEixRN
	QpN/59P5H54IY3+13YIO+Vi+uGFUivSmXhHB61y6bZAQ6bTxoSBCb98Nk9GQY5qg/Ympu0w+yuw
	moG3vNjxCqoLpsrrOXnH36b4ZR2g0wm0XQGQjrwfxtqgEnD9Vdk5NpwPbcj2U3icYg0oRstFSdw
	RBacHCSg/dEMQHktzsuMcwg4B5fCaCvCOiUIuswA=
X-Received: by 2002:a05:600d:16:b0:49f:c1a1:5222 with SMTP id 5b1f17b1804b1-49fcbb0de51mr143310095e9.33.1790090790101;
        Tue, 22 Sep 2026 08:26:30 -0700 (PDT)
X-Received: by 2002:a05:600d:16:b0:49f:c1a1:5222 with SMTP id 5b1f17b1804b1-49fcbb0de51mr143309765e9.33.1790090789634;
        Tue, 22 Sep 2026 08:26:29 -0700 (PDT)
Received: from aconole-thinkpadt14gen4.rmtusnh.csb ([216.212.25.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fde00473dsm3653365e9.0.2026.09.22.08.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 08:26:29 -0700 (PDT)
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
  dev@openvswitch.org,  stable@vger.kernel.org,  Axel Mierczuk
 <axel.mierczuk@1password.com>
Subject: Re: [PATCH net 1/6] net: openvswitch: conntrack: avoid modifying
 shared unconfirmed ct entry
In-Reply-To: <20260921145655.3167436-2-i.maximets@ovn.org> (Ilya Maximets's
	message of "Mon, 21 Sep 2026 16:55:43 +0200")
References: <20260921145655.3167436-1-i.maximets@ovn.org>
	<20260921145655.3167436-2-i.maximets@ovn.org>
Date: Tue, 22 Sep 2026 11:26:25 -0400
Message-ID: <f7tecelb93y.fsf@aconole-thinkpadt14gen4.rmtusnh.csb>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ilya Maximets <i.maximets@ovn.org> writes:

> In a case where skb with an unconfirmed ct entry gets cloned, we may
> end up committing both but with different sets of extensions.
>
> The series of events:
>
>  1. The first clone wants to commit and runs the helpers wiring up
>     the extension pointer into the expectation list.
>  2. Then it looses the confirmation keeping the entry unconfirmed.
>  3. Second clone now wants to commit labels and adds the new extension
>     for that breaking the pointer in the expectation list causing
>     UAF on the destruction path later.
>
> While this is possible to trigger, there should be no practical
> network pipeline where committing both clones without modifications
> into the same zone is needed.  So, let's just reset the entry in case
> for some reason we got an skb with a shared one during commit.  This
> doesn't affect any known use cases, but avoids any potential problems
> with sharing and modification of the unconfirmed ct entry.
>
> The fixes tag points to the introduction of helpers, since that's the
> main UAF trigger for the sharing.
>
> Fixes: cae3a2627520 ("openvswitch: Allow attaching helpers to ct action")
> Cc: stable@vger.kernel.org
> Reported-by: Axel Mierczuk <axel.mierczuk@1password.com>
> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
> ---

Reviewed-by: Aaron Conole <aconole@redhat.com>

