Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795706974;
	b=DA+j1e5JfaArSpiW3Jhms+OyGEsf+DrLxMcRGvMddDnC7yqAPP/WgbnLt2aVTA6bgGvX
	 Nu9rt2UgxZFd7hbqsGKoH4+14v+yTa0QbqWxq4M2FESHAJXjN9zRn+etZ7zC2myXaEGev
	 QH0et29gH8d1xqFZEZ+ptt7N0GbR2oudC9YfDGeUnhGnmZbqsx+QDvYq7tiQqPpzaiccM
	 Z+MBLV5s2ar+1SSgPJaNKZzL9FT5XTw1XtRUczbPoVWHK4fNpf3jHSk2UUEZfWGjcoGgE
	 HoBFLjKmUiznaqyegiXoMUKCRiQ1Fgm/Ze/IEsVNt/7GNJhtZRgMlRjhNZdPfBU2D+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795706974;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=TqDA52TiA5EZGrLT5jnVgiF67AGoOi+mrlY8anEiueo=;
	b=du9rm/frZuAKQJnYqMTwLCx0x6zRyCHpZGV7BOhlVB+zORW6rSV48qYianIe4w4RzvVK
	 larlp+GK9qgWiEHj8SkUeEcHGkBSmKLZtmcxoIgm2IYF/nps0iGS4FDxSsW2Vl2EyPX/Q
	 xg0/0dQn8VEgsLOKsyRS26HvjWkxtTM47KuDx1toERjlTt/Hl7l+ZP/JdMpjvG1kh/zCn
	 TJpL8yu18gmRwPgrMHpROR07XFD+19PN2csaSfUL/eE6tfxhCvbZAL78b/NyRXP+rziTP
	 8T7t/6PRTo6HLMtZuJZ383JvFiGP363ZygEBpywmApcoVbJHRFn752vITZv0qXUFMnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PnwmdSQc;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C14C606A321
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 15:29:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C14C606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PnwmdSQc
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-38644aedba1so10649807eec.0
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 07:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795706973; x=1796311773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TqDA52TiA5EZGrLT5jnVgiF67AGoOi+mrlY8anEiueo=;
        b=PnwmdSQcYMwpr0abDalRR1yI8sCnDsViuonW/GEKNPJKfacnJAzLa/aBABAtR/ZSMz
         W8yzmAeTXA4M+yyvWejoNcGn4NHkohGRZyFb1SYv1ox6v86HU37l6E8KolndzATLA0kw
         dcMXfM2ZGwjgfdSSLUZWNXwlSdHKK9NYk22a4pkOMd0M2dRswfaDCtMMRCs3OWpG+YZ2
         slttFZVW4I1LSVa2XSsagLmqf8yivhE3AK2zcB95Zn25hb9yfMXhrWYD5DT/pfA+9Zss
         QlE1dWGxq5yVo38EzMCPfQ5dSDdMJpg+8NI/14wndrlMpd8f4hahPO+gY9iVuAlkrzkf
         jjRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795706973; x=1796311773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TqDA52TiA5EZGrLT5jnVgiF67AGoOi+mrlY8anEiueo=;
        b=o3Kl3ESxUQLKE8Bm2Rk0TgmofeMGE14b2ljlFX8bOP+7UiGM0Q+9tgIuZTafotCUUK
         Y00+gYkaM0pIZ0P2jgz3QnpZYRNG1wif+k2Hg5uIG9muinH8eNKIhMfejC9VU2BHm9eI
         Y2/TMEyjFdScYZDzrhM80cdCMWQkUDr6LLXXdZt6x4PjhNL2FcqIIiXX89MxHlO6zoh1
         yelQu9VHGy22dZ4pArskbOsYJ/jQxL3MBP4lQ6gOE6C5vw7+YUdea5eiwyMCIwRGzvVM
         zuBB1qJM0qc36EpaGstLtgzOo9bP+bFO0Ux+XoUmI6/UE25czvJabrycL4K20OCFIa9Q
         eIXg==
X-Forwarded-Encrypted: i=1; AL+hErEzGYKKFMoFgKrWaVqGugygG41JR9TvITnGNe5K+Jd4+eOFCN2qy+MsHl4Y4g/FcIzhNa6hUmw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+jiIbvAQtBZ5fvRfSakEO2DpCU2l36OLtbcC+qDpmbJeq6hNsc
	qEh3p+CYW7A11KoqEc0iB2VvMRylRkyztRegto5VzVzY+tbeyVjQ8A6F
X-Gm-Gg: AZFdTZeEzyiX0aLaahGJF8JRECSPdu2a2M2YADGLgC6ykP9gRiHpgFpUvHa2EWWjJ6Y
	woA6w+6s8zliwPP2dxrYSfNoR8Bs15NF3X3/dRadk2A7JRoqKH2WK2isIm+ewmr9oyiSFhEzk6s
	fafV4PUDxSh4iTH2AvfXkWBLQJsp3Vbvl66Z17EUzgvTnVdkxFw/j6D/liFfluE52gAZNCL6lCz
	YFAFXRbKRhqdNA2LxvxxgIK+rH+Ifeoi5sAmwcTFD1BWu8L+qQ+ipOADsRKZAnc66Q45Xg49hy5
	KZihTqq6BlF0vqq9DlJuIM4XD89zekVItyQHFsYtaVhzivfz4COWcNK+Q8TUDoESqM1ydIacn6u
	qTW2hhkY67km73H3tpofWKe2KTAWld6ZPNCN7kZu1FdMnKgw3jAhIcmi417RFisEa+bIKeu36/9
	Qw25Tlx/Amm6gdfGI73q+KOC9AGVERl9o1DsaQYeWv09W2kblzEhRQOOp07hk9WOj46ld5Rl55n
	h1HZ/7UTgXDduoigqtwSG8qTPDDlfuty3B2R2k39YtZCMfocgl409ZwQA2Ut5c3Kl1sytQqjjuS
	7HaFG6ORYJ/AQA5qFXabjNgkZVvFrDf14nM=
X-Received: by 2002:a05:7301:e0c8:b0:386:c724:cc68 with SMTP id 5a478bee46e88-386c724ceb2mr7058487eec.2.1795706973233;
        Thu, 26 Nov 2026 07:29:33 -0800 (PST)
Received: from mptcp-lab.w453y.xyz ([59.164.88.43])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385665f21aesm77580388eec.4.2026.11.26.07.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 07:29:32 -0800 (PST)
From: Abdul Wasey <w453y.me@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>,
	gang.yan@linux.dev
Cc: mptcp@lists.linux.dev,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Mohit P. Tahiliani" <tahiliani@nitk.edu.in>,
	stable@vger.kernel.org
Subject: Re: [PATCH mptcp-net v9 1/2] mptcp: pm: in-kernel: fullmesh: skip closed subflows
Date: Thu, 26 Nov 2026 15:29:27 +0000
Message-ID: <20261126152927.3924317-1-w453y.me@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <c9eb1633-ea90-4b86-b7d5-dc3c7ba2bf1d@kernel.org>
References: <20261126101818.3916631-1-w453y.me@gmail.com> <20261126101818.3916631-2-w453y.me@gmail.com> <0f1d9633b78cdacd57f4c235a5a787426083d788@linux.dev> <c9eb1633-ea90-4b86-b7d5-dc3c7ba2bf1d@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Gang, Matthieu,

Thank you both for the review!

On 26/11/2026 16:09, Matthieu Baerts wrote:
> On 26/11/2026 16:01, gang.yan@linux.dev wrote:
>>> +/* Closed subflows can stay in the conn_list, e.g. the initial one: their
>>> + * addresses and IDs are not reliable, possibly even reset.
>>> + */
>>
>> What about dropping this comment here?
>
> +1

Sure, I will drop it in v10.

>>> + /* The initial subflow can be closed: like fill_remote_addr(), use the
>>> + * remote address of the MPTCP socket for the remote ID 0.
>>> + */
>
> While at it, you can short this comment to something like:
>
>  /* If the initial subflow is closed, use fill_remote_addr */

OK, will do.

>> Another question, why don't you just use 'full_remote_addr' here, like:
>> '''
>>   if (!test_bit(0, unavail_id) && i < addrs_size &&
>>             msk->pm.extra_subflows < limit_extra_subflows)
>>         i += fill_remote_addr(msk, local, &addrs[i]);
>> '''
>>
>> It hasn't been tested, just wondering if there is a specific reason to keep
>> the duplication here, as I would rather reuse the existing code.
>
> Good idea to try this!

No specific reason, I just didn't think of calling it from there.
fill_remote_addr() already checks remote_deny_join_id0 and the address
family, increments extra_subflows, and returns the address with ID 0, so
it does the same thing. I will use it in v10, and run the tests again
with it, with and without the fix.

I will wait for the netdev review of v9 before sending v10.

Thanks,
Abdul Wasey
