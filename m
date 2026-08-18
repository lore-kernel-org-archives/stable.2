Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B5E455161
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 11:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787051500; cv=none; b=jXreXpCs0LNgFXAsEbfN2sIKnslsMvHxK+vWbIrj4EdPTmZQmgzgHLqprS+rlVPFEq6Fglcf5WUD2IqIYQ3bSsdXbPq+yXlTA0nd92SpdgNP6y/c1YoLFYkcb075WD4dcyIX9wbpUBcg1odAJmVoLXeLlh+c4S1+PWtzt3Qtu4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787051500; c=relaxed/simple;
	bh=BbY6AugiYJJO+Aqx8xAwWg0CsYBvQjrLuUBuwkgsj7Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Fu7rpVVUbEKxmSbQtnwU4M6oAXm63CuZz+mTtiDhbhhAwZftg//9I234zBD9QpAEVVWTCiCTwNWu0XQJx6h3R9S391FZIWFQ9OHskwnU3A/NX6jk8l/m57NNHTRTdPUviYR4kUXjrPd/ob8UoifheD8FIXw4uEDJzYmiHrEdc30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gNSbI3B/; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=IPVafMcR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gNSbI3B/";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="IPVafMcR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787051497;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q7xmBaR8c3MOstN/SERsMR2kSJUtTOjfrtXkiSiGFzw=;
	b=gNSbI3B/gy4lNsBY50oU0N8Z6Gi+VSL2KVl/QKdYcbR8tpG8YnghBmtq91d0YlRfGraXC4
	fCPzSLoOiGGh3RA7uYtqoCY691gB7vIX0V+OFDsK9sbzipwulLJD8dzMviPE3dwfHbOg90
	eaKFK4wp28GjTyuUu4JJ453zElnuNDc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-62-iqlrpZeSNICshBRioSaX4A-1; Tue, 18 Aug 2026 07:11:35 -0400
X-MC-Unique: iqlrpZeSNICshBRioSaX4A-1
X-Mimecast-MFC-AGG-ID: iqlrpZeSNICshBRioSaX4A_1787051495
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-47f4bff865cso2443051f8f.0
        for <stable@vger.kernel.org>; Tue, 18 Aug 2026 04:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787051494; x=1787656294; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=q7xmBaR8c3MOstN/SERsMR2kSJUtTOjfrtXkiSiGFzw=;
        b=IPVafMcR4tzMz4HZbMLoLm3J9a9pyXAjuMGsNBUvddu7HQ/VuLOE02FhtIwvh3af/e
         eBXlgc0pkyMzCZ4Jmg+NMM0ncWwO5mJclOjEYLCaP4zMTt3ahdS+7wXuOnVIOmfMesjT
         GUqIr76JvR3Oa7GL1K+u61GOAEtl1H2BlKGV7RCtIwPBLsfSzzEPn3oy51bzrHh4wJbz
         NuvB9wpT+GWxOOaoM9X7SIKz0oCkWUKMQ+9uXsXHEkdx6zPoihTyGDHGttxR/yzw0lU6
         jqJtXaTH3EtwbprDX/Xx4hXpfm1db5IZM6teyFAmo4U8qDHxTtAGMbuGAJp+waKwG1ys
         BA/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787051494; x=1787656294;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=q7xmBaR8c3MOstN/SERsMR2kSJUtTOjfrtXkiSiGFzw=;
        b=cX4gJR3gbWCB+ZAZso0AbmtPtIN4t4kTkbDShJxUwse+oRWWlYO7Hx/eHoKauPzKP+
         aRDEMeg0db5zxIyRYCricrNjugCTSy+hMVySvLdCPLse2ffLfaGffnaX1yGbZhkPGALC
         WhYKAjTfp70eUD7tNq2/v4MLYlD/oVCKQy/Ib+xMFxK0mFO1z4Gl6nNlncViZjy54uhP
         J1cY02jD3AyRuZ5acl/C7xxKHmKn8VE0ZuEwg8cSprsJ1Zz8qUwvNyl3t57Uk0zZO7G8
         dJf90yk5zP8kX5ynRsO+sjVaoeO8YZpL8kU6npbqjqVn5WLZ2vgbpqB7ItBjmN1OI5mE
         /Xvw==
X-Forwarded-Encrypted: i=1; AHgh+RoHuPFueBKu31NcVx5Su9hk426DodBndgdxJsM6CInR9kX+iiUo286IFVf8w7z+j6BjSmnf2ho=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9IgKFV6VBZc8yS4DZL5guek07m78M/lWJE2Pt+xNS3C5y/0HE
	NgrOQbwhEr97nbslcGEYFlM7sjiOLjMZDBwv14mq1i4IZ1DUwcCWGXhMqt/yZEDYHTx1zAv/zDL
	29LwbCbBdisppf57WwYsFkkxw2xeHoPzuVD0+2Q86U5fbKTguJKLKo3BL0Q==
X-Gm-Gg: AR+sD105t5Gj2MdqyNMa3C3xfx/P3INPoLmsQY7KwzJ94emcHJ5FoPV/T8BnvX7VidA
	1QYAa9/uLzZiJNCmIHgsq4Qzbe4MFfEyu6rj3IByfFR2NdseoaN3blWUV8Dm9bLKzXUlqi7dl0y
	hTkFSxrnnJ92BeQF4S+oh9HFKTkQ8urFp7E2b2qDGTz1WefM6sKaBONHkd6j8MYa7NWt1MXlL2l
	kqbc34fsOE9SCLCeJbAj+TzMUtsUWi/SPdW/Bw2WwwXRseXdfOHZwoNyx69xHaNLw6bMaNqggJ7
	1Su4qL7UNARyvckui/T6MLZKwIth5VgT/krvi8TTylPSHRSg3ojlSXKOD9zAJLkZvCmoezLckVV
	k+0n5j9EFkVRBgyvl3pXcECyXSK3o6bx80fpQYAI0mXd4oIRFtLbbliBeZQATDUXuClnk36ktb+
	E=
X-Received: by 2002:a05:6000:4201:b0:47f:e760:e5b9 with SMTP id ffacd0b85a97d-482a903c1c1mr11739161f8f.18.1787051494519;
        Tue, 18 Aug 2026 04:11:34 -0700 (PDT)
X-Received: by 2002:a05:6000:4201:b0:47f:e760:e5b9 with SMTP id ffacd0b85a97d-482a903c1c1mr11739063f8f.18.1787051494124;
        Tue, 18 Aug 2026 04:11:34 -0700 (PDT)
Received: from [192.168.188.103] (ip239-44-231-195.pool-bba.aruba.it. [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482a5a7bc6esm11928055f8f.19.2026.08.18.04.11.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2026 04:11:33 -0700 (PDT)
Message-ID: <3bc731d7-38c3-4ffd-94f8-e59cde66f5db@redhat.com>
Date: Tue, 18 Aug 2026 13:11:31 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] net/ionic: avoid OOB TX partner lookup for
 hwstamp RXQ
To: Anand Khoje <anand.a.khoje@oracle.com>,
 Brett Creeley <brett.creeley@amd.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Abhijit Gangurde <abhijit.gangurde@amd.com>, Shannon Nelson
 <sln@onemain.com>, Leon Romanovsky <leon@kernel.org>,
 Eric Joyner <eric.joyner@amd.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, Kees Cook <kees@kernel.org>,
 Mohammad Heib <mheib@redhat.com>, Jacob Keller <jacob.e.keller@intel.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260813083705.454897-1-anand.a.khoje@oracle.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260813083705.454897-1-anand.a.khoje@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/13/26 10:37 AM, Anand Khoje wrote:
> The dedicated hardware timestamp RX queue is allocated with q->index
> equal to lif->ionic->nrxqs_per_lif. The normal txqcqs array only
> contains the regular queue pairs, so using that index to set rxq->partner
> can read one entry past txqcqs[] and then write through the derived
> pointer.
> Only link RX/TX partners for normal queue-pair indexes. Leave the hwstamp
> RX queue unpaired, and make the XDP_TX path abort cleanly if an RX queue
> has no TX partner.
> 
> Fixes: 8eeed8373e1c ("ionic: Add XDP_TX support")
> Signed-off-by: Anand Khoje <anand.a.khoje@oracle.com>
> Reviewed-by: Si-Wei Liu <si-wei.liu@oracle.com>
> Reviewed-by: Shannon Nelson <sln@onemain.com>
> Cc: stable@vger.kernel.org
This is net material, you should have set accordingly the target tree
into the subj prefix. Also your SoB should come last.

No need to resend just for this, but keep in mind for future submissions.

/P

