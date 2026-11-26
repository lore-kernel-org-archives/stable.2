Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795685664;
	b=rfvkZj8JFysJs6nur0QkpylrpZpC6JvkwHYljpeYsK62Iq/7d2AaSmnNlZvQdMKENCYY
	 rRM2uE8/qJG1Mkza3+E3VCaa1l3UVoCzM5uTrn8M30JUQCMNJV0cjm7enYjUKel3+4np5
	 Gs7nsNkwPgneRvjb6eLtDGRFGai+1bvYRrnQvmP6XKpVF+xSU3ttqJ2EnfZjMMQLnbJu+
	 PPUlAiu6emNJDoVtkS2yMtlKFpi6auKfc7w6L72TaEzevqrkvzFV728Ki4ftLb5bNu+g+
	 LwZFKFpL0lLXi+PETTa3JiScC6jpVC3AxBhioMBddP3TelkRZdfV42g7Ev4hl+h3Gmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795685664;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=itCjuIfyFywfPE2jt7Ui8jJPSuZ+kYwvFoObcBS2K3k=;
	b=BLvC2/FpJGa3115W+pVbaMwdUoTs/P5UBCM3WjpZ7X4YFQw0CoqZMFQ2TyMzv6YSv3Zg
	 AlTMPG8yt5xYk3X2Ymn/l6/HBCaBr/Rjl2CnstVXEZsQfslde7QHsilKsrnNUlxk77Xk+
	 WJcATniyet0J6iC2mKC2I83rablLe3kBJzseJ36UqPFx0sgQxgfR2d9JxXvRKmvrs37jx
	 y7OE7mQ4MRZ/jbbV64yNhituM9JyUsB+B20HqNtWzZoyqPN0qOyNLFxNe0AJRHolAPGLb
	 mVTEfyshQ9EHbcmfcEv4C9qOeORhxm987Osmoe3d+6IX6fUDm3ijrTTo4iWN+wy6OlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TJT2XVr9;
	arc=none smtp.remote-ip=209.85.215.181
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7A1606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 09:34:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C7A1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TJT2XVr9
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cd6028ff33fso3505326a12.0
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 01:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795685663; x=1796290463; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=itCjuIfyFywfPE2jt7Ui8jJPSuZ+kYwvFoObcBS2K3k=;
        b=TJT2XVr9pYrgsry0KXz8sbTbk3KWbTZjaSt1O3fjNva0NK6fgS92jZrGLqPa8V2iee
         O019+x4gUEYFnJu8QdCiyv1dc9D7eO5Bm37ME1t6ilEp4obaOkVNV5HekNPdjXQLCHGM
         2ucgwz/nPSBG1uh7yoHmsG9xeof0BVi1lhNaQlE8wF+Xp5CeTETllsLE88oMQ60s49Qz
         4GfAZ0hYYdX7XGZwo1G/4YmCvA5w8N90JrC9UEag5mLA+Y198q0uxuu7FIF245dOxoLx
         UWi3wbJ4WDB/q7v1fPclWNkV9xuVdbGL6gWv5TNsVCAmEqsaKxVWxDhxZjSqcsPstBgH
         yE5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795685663; x=1796290463;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=itCjuIfyFywfPE2jt7Ui8jJPSuZ+kYwvFoObcBS2K3k=;
        b=nDZK4OV5+JZibqII41BYAINYPGYuDNgP1w3Odm2/mcSIeioyNnel8BfATZ4XqOlam/
         XgUixPZA1E+oq2fBUh42s/tAmVMvmCN7nKiqe/78cvDFglu2mAPFoF4SF2Q8mZ2Bxv25
         3St7Kpe+x5+/mWapQmF6qXbE9MSKwHqVZQfw83MVRAyzyFcJSrcioEq7eiSp6j8J+557
         plhXfLI5MOZ8AbY40MKwTwGS6yQsk1hH91TzSVWj4f6IiyOsnIB9aMJXokCxM1Y5LBgP
         VLz1JFVrCuW91HRYJHMmurJa6ycHrNsE0XFBq/HR4sKoAeH8lrgvRYB63ym4bxmsAb9+
         XBNA==
X-Forwarded-Encrypted: i=1; AL+hErEUraX/PMOf4DITbUhl184s1yB6/WgBkt/L4p8eVIqqZedwA71RDZkMz5RwDLzrxvi0dC/tAXg=@vger.kernel.org
X-Gm-Message-State: APuU4Z9RyAPmQpmDIZbnd3vXL1Jz0poUiTpsx0jRY7f9ZCqklqoNGgf1
	lk8q7Hiv4SfEeFKrAW6e7LFm9oE3/E6HBgqPv7TSDDHQcgDZbv9E32Rm
X-Gm-Gg: AZFdTZeJl884ZMpA0Kt9z2Iz8NojzxCzClwttXupBvztyIAVr3JZXiJu1MVlODo8RGh
	XIno6ra/MhUXvGIDbR98Dw5jQ/QlETmEi04RgBlfFn4CFYT9d8ywWdRjPfG7IGYP3iE/shapUfY
	T+u6JWcATML6kQs3fcI9k0CaOfbualvp+Cq508TaK3Z1viQbr6idgDi84uDIcrVu2D10r05tCT0
	Jza/zcj+Z6xAPQRhzN/75MJN6LWoxIzyNoSyj2Ya227+KNnD/6HZiI2jggLGytysm0cu9LtRplT
	Bi4yJg3RiD/OQzvquBLVfekxySTNFTVsnMO4HlZqfoYmjFkFkD8YGSAsQzYtbyJ/lCEaADv+wOp
	QtAHLEclAHVXjgXhS1wlH4Drl1VpKKAIfzEXym/YDOc/k6MwyO2rWMgMu0Xrh8tE+W8TQTmQeQZ
	qFI+NK+VV62ZaUkqZbxc7xZgg4jnAaxbJszGMCpmSh/QrUMsfLxwvNhACxxXGOth/PqK3ElZixQ
	MFQJQp14IRnoj+PWRfQ931cGg5++3kf6DpcItia83vp0qB1YuB9ecA7CGt8DigIRXu0SdQejfl8
	9g1TYEHvEZa3XOgCjKi0TjaZpGUUUQ47HdUPm0lF46/Cp6s99AQmyFGG8R4OzdjMbwI8Om/YbIq
	cHriGWA==
X-Received: by 2002:a17:902:f645:b0:2ef:dc42:10a9 with SMTP id d9443c01a7336-2f03ef3d32dmr216044935ad.7.1795685663337;
        Thu, 26 Nov 2026 01:34:23 -0800 (PST)
Received: from [192.168.255.10] ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03ee844acsm103955985ad.2.2026.11.26.01.34.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2026 01:34:22 -0800 (PST)
Message-ID: <5d1f3ff8-b995-4496-a59f-2a01f38603b1@gmail.com>
Date: Thu, 26 Nov 2026 17:34:19 +0800
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] openvswitch: reject negative L2 length in
 ovs_fragment()
To: Jiri Benc <jbenc@redhat.com>
Cc: aconole@redhat.com, echaudro@redhat.com, i.maximets@ovn.org,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 dev@openvswitch.org, Lin Jiapeng <jiapenglin@tencent.com>,
 stable@vger.kernel.org, TencentOS Corvus AI <corvus@tencent.com>
References: <20261126083218.55429-1-ljp1205831794@gmail.com>
 <20261126101410.4a310394@jbenc-thinkpadp1gen4i.rmtcz.csb>
From: Lin Jiapeng <ljp1205831794@gmail.com>
In-Reply-To: <20261126101410.4a310394@jbenc-thinkpadp1gen4i.rmtcz.csb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-11-26 5:14 p.m., Jiri Benc wrote:
> On Thu, 26 Nov 2026 16:31:41 +0800, Lin Jiapeng wrote:
>> From: Lin Jiapeng <jiapenglin@tencent.com>
>> ...
>> Reject a negative offset together with an oversized one and drop the
>> packet through OVS_DROP_FRAG_L2_TOO_LONG. Valid offsets are unchanged.
> 
> This was supposed to be fixed by
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=78a86d75a70e1e227711c72865c59b1422d0a5ae
> 
> What kernel did you reproduce this on?
> 
>   Jiri

Thank you for pointing me to that fix. I reproduced the issue on the 
then-current mainline, commit
4dce97c6c265544342e716e62fd24bbb232590c5, fetched on 2026-11-25.
I also verified that 78a86d75a70e1e227711c72865c59b1422d0a5ae is
already an ancestor of this commit.

You are right that 78a86d75 addresses the original issue. However, it
does not cover this particular variant.

The existing fix is reached through the following POP path:

     do_execute_actions()
       -> pop_mpls()
          -> skb_mpls_pop()
             -> if (!eth_p_mpls(next_proto))
                    skb->inner_protocol = 0;

Thus, when the last POP specifies a non-MPLS next_proto, the stale
inner_protocol state is cleared as intended.

My reproducer instead installs the following action list:

     PUSH_MPLS,
     POP_MPLS(ETH_P_MPLS_UC),
     POP_MPLS(ETH_P_MPLS_UC),
     OUTPUT

This takes a different path:

     PUSH_MPLS
       -> skb_mpls_push()
          -> record inner_network_header and inner_protocol

     POP_MPLS(0x8847) x 2
       -> pop_mpls()
          -> skb_mpls_pop()
             -> advance skb->data by four bytes per POP
             -> !eth_p_mpls(next_proto) is false for both POPs
             -> inner_protocol is not cleared

     OUTPUT
       -> do_output()
          -> ovs_fragment()
             -> skb->network_header = skb->inner_network_header
             -> skb_network_offset(skb) becomes -4
             -> the signed "> MAX_L2_LEN" check does not reject it
          -> prepare_frag()
             -> unsigned int hlen = skb_network_offset(skb)
             -> hlen becomes 0xfffffffc
             -> memcpy(&data->l2_data, skb->data, hlen)

After PUSH_MPLS followed by the two POP_MPLS actions, skb->data is four
bytes past the saved inner_network_header. Because both POP actions
still declare next_proto as MPLS, the clearing condition added by
78a86d75 is never satisfied, even though the label stack has already
been emptied.

This produces the reported KASAN signature:

     BUG: KASAN: slab-out-of-bounds in prepare_frag
     Read of size 4294967292

So this is not a case of the fix being absent from the tested kernel;
rather, the all-MPLS POP sequence described above is not covered by its
clearing condition.
