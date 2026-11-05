Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793887042;
	b=AQMKG0ThORAQM1Oa1wzoCEHCu8+C02EL6a4X33t50fAKCQuAWHWvZD/h0ojuFtiVs0vo
	 r1iadS9p8r4L4z9q3uuUfVXYWL48qkYjUWbBitrN53HnT0C8vj/rkkb9Z3AShSAqvMVso
	 kf4nQOiJZtDXnaFGcEdGg4rHA3RJzJSXHeOhnY3GjJMJkcqQh4+07Yv5QebR9gqJuQdbS
	 8vIY5obCKKVai2crhROIdE6JSNe9sqGXiHPdUk3OnEI1l2y3SIrqtltvfjCIA/F2h1qbs
	 +N3QsgvMle//Y+zokDmVfLV0K5geM/mOtPNPClolmzEjs5vYTSWx/uDJZ4XVEyLLzQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793887042;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=LugeZGb+Fl7OEGgjSES9UdL88IWgFCStcMs3asT+ykY=;
	b=1ttmFuMvQvd/NiKS6vNV3Lgf81JjwwWAcodlF+hi3e02nyhFtD7ouoreKH2ouui9AbK9
	 SjWWkjadQXVc7usp0MB3Qf4aYxHNHuOyCoeJhJHkAxkxSaR7XO0doUdhyNn/HBffo9dwY
	 8Ez6uGzDlKjdULaGqUvMRCs4uYUOOuTeE5I1yq/cIZ41zPDkjwlBR91lie/Vw9XbEY8jO
	 EkQbHjBOrJn+sYavWG1Leb0ZDSltVPyqFstJ5bO66uTAias1j4x1nOWfXL5+E1eA9lOUb
	 jDrMIeqHFp4Jnabi7g7JXcAt9xlJ/NRO9JHKbHLzzukrlnYAKNpPuwgF38XEf5GSQ+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="R/WL+4qx";
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=U2Em1hJC;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053F3606EE92
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 13:57:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 053F3606EE92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=R/WL+4qx;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=U2Em1hJC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793887040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LugeZGb+Fl7OEGgjSES9UdL88IWgFCStcMs3asT+ykY=;
	b=R/WL+4qxRVGSNMsUvHj3KhfGQTljIUNgBbzdebtSvv7V8MHqaesQio7Dja1shp94xzElgU
	jJcyO0XvoZqknYBclAZ2ctC8PWKfdkoLoQotO7QddOGgUYehTh11rbzLAURpZHl9P4kxf6
	knaMi4Q90Zvfvdt4Genu9w2KPj+fkkU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-144-7ETGQfasO_W5v4ah5QgZnA-1; Thu, 05 Nov 2026 08:57:18 -0500
X-MC-Unique: 7ETGQfasO_W5v4ah5QgZnA-1
X-Mimecast-MFC-AGG-ID: 7ETGQfasO_W5v4ah5QgZnA_1793887038
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48c6a1d4034so1675470f8f.0
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 05:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793887037; x=1794491837; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LugeZGb+Fl7OEGgjSES9UdL88IWgFCStcMs3asT+ykY=;
        b=U2Em1hJCFVfRXkgj9mzgfMQoYYzaBAJvSWu17U/Jr8cUWtBJp+eeHEMlD1FpI/JpvB
         kvt4QveGVLJ9kHjXFQ8xpPb0dF1AHrA0CyZP7bTme4ixhVqz1G0qPeOZ1RX6XsypOaKh
         84OGkDCFItDVuyh5kfk0JNtYaFVL8Q/c7lW32EQ+Nd653Men4v/kBsU5LLk3c25DQVhM
         fT4A1rvarEMFqGNEM0x2cf51xsqgizYMVprOknxjcE07YbT2xflEQ5bUK9AkDckLwZ54
         tIOOaUmvnEfeG0bn455r6UoGyU99yuVB32grQvGSZdbelD9/dYlIByqIUBDzSxc+Wv+M
         tdKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793887037; x=1794491837;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LugeZGb+Fl7OEGgjSES9UdL88IWgFCStcMs3asT+ykY=;
        b=GgOSRq1oF7wzhZxIG66yyC3+MNY9xr8vuNMBUdjMvvHH175nsPgqApS9I44Wcwgbhr
         whHk1ECpQRR5ERqHrye60fzNQkJlesl2ksubrH0k/dCzDiv0BcXsNMTuVx4w9nXlIukZ
         qZEyBbbi+i+JVy97VnaWSKAcFGKsNHzzGnuLzJDZbldTXUdaCdVLl3sB6J/5Ge9Dy2ho
         OsorKfC3D2FNeO2G6yJsJHrzbvFwmL1dxqzPmGIZQL3j+CdSvzwNuv6NqNTooou6ekzo
         t88RH8CIDHpX2ThzHLjYarF8ciXQRmlccsHfJK0DSd3V+51eNsbBTUKZiE3LPTa9vifb
         jrSA==
X-Forwarded-Encrypted: i=1; AKwUvBx3PQfEzvZhp8BH2F1m6GuvJXXJ0t/504VJs5F39ep5De3P8NZttCyQYKSD+TvHFMh/QAbUolc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Mf4Vn7dbv5okGUT5Zf2gNlquSw0OgbahbVQpj3VErzah/f4KZ
	CBtAklQk0vdLGxy8T3PZUUmomWtxJLOlGE8SXW23ViIsEFBXHGE79JCKypJrbFewLRc0XzL/3Wk
	PkT9sASrAtYLIta4gpocQYUQACX7Gaj5OvAEsK0/AxIxDPeGrVOyO+WCAUA==
X-Gm-Gg: AYBFou3v8AvdA7T9JGbrNRAzW2Nj02Kh9TxzGX3xkICp46eK2VuQjXRifWzEy3dgznA
	8bNlpARTBQSEOK+6JuuRSb6/PIOK/kZa6YFVeNX95vpGMfwGgsDWK0avfpAdcW20Y8S3DdGuUUf
	6zQg8MrOcj930m/4cHJqHTfAgAUGhbtzlJ6bHElhLRlhXFlAvVAnwo45CKAlsozt58qL74/2LdD
	t0pQUWGpSsFvcT2FB6cyQRiug1PbXfPXlZbBa32whgztFxD9WruQWIw/tXqfjx3l4kixReQLDBV
	hqYtMFGy5cyTInYgW8yImJGnw10EAcq2abg7dEWIL+FELlKR4pmJdvlONnoG3coODMKLxMtvZ/7
	91a0al7ZDVy/01CVtg+7AiTrLKTYngmuf5X1MRxJeXgA7az1bNeO7h6CQbXRiqd2oW9frCPJ0+x
	jZe5cuCZWM8LBstWtJcFeByADbbJqgKXNCaIstqs+DiKs=
X-Received: by 2002:a05:6000:3c4:b0:491:273c:9649 with SMTP id ffacd0b85a97d-491273c9731mr4515074f8f.15.1793887037385;
        Thu, 05 Nov 2026 05:57:17 -0800 (PST)
X-Received: by 2002:a05:6000:3c4:b0:491:273c:9649 with SMTP id ffacd0b85a97d-491273c9731mr4515030f8f.15.1793887036899;
        Thu, 05 Nov 2026 05:57:16 -0800 (PST)
Received: from [192.168.88.30] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fed45d2bbsm10667066f8f.33.2026.11.05.05.57.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 05:57:16 -0800 (PST)
Message-ID: <be1607db-4d7f-4a35-b1aa-0b0c35220407@redhat.com>
Date: Thu, 5 Nov 2026 14:57:14 +0100
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
Subject: Re: [PATCH net] dpaa2-switch: fix port cleanup on probe errors
To: Jaeyeong Lee <lee@jaeyeong.cc>, netdev@vger.kernel.org,
 Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20261102071310.3004332-1-lee@jaeyeong.cc>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261102071310.3004332-1-lee@jaeyeong.cc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/2/26 08:13, Jaeyeong Lee wrote:
> dpaa2_switch_probe() reuses i while probing ports, adding NAPI
> instances, registering netdevs, and unwinding failures. Consequently,
> the value reaching the port removal loop does not always represent the
> number of successfully probed ports.
> 
> If IRQ setup fails, i is left equal to DPAA2_SWITCH_RX_NUM_FQS. A
> switch with one interface then causes the unwind path to access
> ports[1] out of bounds, while a switch with more than two interfaces
> leaks all ports after ports[1].
> 
> If register_netdev() fails, the unregister loop consumes i down to -1.
> The following port removal loop is therefore skipped, leaking every
> port netdev and its MAC endpoint reference. The NAPI instances attached
> to port 0 also remain linked while their enclosing ethsw is freed.
> 
> The issue was discovered by a static analysis tool and confirmed by
> manually tracing the probe error paths.
> 
> Track successfully probed and registered ports independently. On
> post-NAPI failures, unregister only successfully registered netdevs,
> delete the NAPI instances, and then remove every successfully probed
> port.
> 
> Fixes: 0b1b71370458 ("staging: dpaa2-switch: handle Rx path on control interface")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jaeyeong Lee <lee@jaeyeong.cc>
As per Linus guidance issues in error paths in NIC setup/teardown
do not qualifyfor net nor stable. Applying to net-next, with stable stripped.

/P

