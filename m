Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6446C39184E
	for <stable@vger.kernel.org>; Sun, 31 May 2026 18:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780250691; cv=pass; b=O/eI32I6pCmAQ3vFA/4DKTnnNkigaS2KWQARN9qIW7NkB1ii8jSp9SEkzwPsHa9W/aYl3eYf+2EL6WZuUPmXq+rYhYU//Uom58pONMMjxoyywFrwXcuBAylXRiqMa0+nspqr8iGjwePqqsI7HF9LSP4THj5tVP/aBFylKT2xlTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780250691; c=relaxed/simple;
	bh=ofZSq7G8cMrSjcMKXZDuMvlm0WO9whahFj4x6LbtlRA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r5BS4PKdmS8EXkdvCwuPEfwGcEbNITVLXEhhy4vYy+2tCyWfvigr0T3iRjo/z0bqHeM4A7cFK1wMyPCiHPA3nSBMBs2GxwfpvOq1cuQ4Ik8JlsAUumNUZ+m8r5BCe59rlg7WtQyZ5yVNxYrQj7sdT7r89bzTsMKD6vRs78l84Xc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IHiRfkZ9; arc=pass smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IHiRfkZ9"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8ccdf8d4ac5so30787286d6.1
        for <stable@vger.kernel.org>; Sun, 31 May 2026 11:04:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780250689; cv=none;
        d=google.com; s=arc-20240605;
        b=FUDSYnqqGXL97DvZAzhQAefUlpwLKcjOwprjXSCXYd9mbMfrMm4LlyvzrNPXtY3IYn
         BTUQVceuVxqP+lCj4qiY+8OrnFdtSZANmTbkonAwCoZ3R6cwBKHKbTnOckBguFf2BsI1
         WSKk31aLlkkBgAPIQwIOjGE3ktUIvJCiNZThIOG/EJ8q4HvU2S10rLiNEVgnDX6/pmKp
         tcotMg0lfP3Z0XlnHPvvp6bPn+SFeuSQLJdlCMwo81DwU7CAgJub9WOO9dEDAmrYR0OF
         psMywQsU0YofsYd3Lch3h42gRdekJDeRny366lU8902i1J/Wvpsboc0iQ2uKhg5pHTQV
         W15w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fhEgvzKeZCQs4CyiQC8uzW7u92ha6iJGj4bzQloVlmc=;
        fh=LtirZrbLLUdgOryeF3uKsWK8c7hB8F64G6H5AAAElpM=;
        b=Sfoak1AiFtJTPNmrWp5tJrvvfcwFI+PadyIUlTRlxfZiSP3nAoTMinTfaA0B/4UfWK
         6OFWzMpAQ8ljh8yDCQrCalIwsuOhgGJq7uSRsb02Ey9et4b5dyF7repchwhpNqzBnywo
         is34FG+Pvhy05zR5bZ0CWrf/VZ0Pd7x91C9DWz5cvTx4RjPefzP35J6An4eawUObyVip
         GcVfBX5911ns+ewXepTquA61QREydcFKy+yM+yNBcTV/h5WeSZDGi24dEelXn0cJ8Abh
         aud6Mwpw8ys2fCoMYmvJWGU4srKhCDs92ghvTI49962DhuC7sdyyWoqJJH8ZfeFQiovI
         3NEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780250689; x=1780855489; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fhEgvzKeZCQs4CyiQC8uzW7u92ha6iJGj4bzQloVlmc=;
        b=IHiRfkZ9x2g+7ZCtlJbzdGS1y7gSc4s0TNoLz3bOBqkm2SHM8tEO7T+POkonjkbZ8t
         CQugdPM9FEbmk44VeEH0wtHRujXfG/NNyIs6tRovHakG0lqulFSPgZEbMSKpWxeYAWUP
         GDWUAuUK7Nl4jbeevSikUdjlbhcYnvebW7+J2tslH42TfqoJlj2mITgLHx0TJVCYNK8p
         yYN3wQ+dm5tcK5unbqAyvTN+ZYvAaS/df9jIafoYJwWvUDV3dbAv2/by8FQlAJa+iXCn
         c/02eJlvMlfYbcKKnGLQg9ax0iz+OjCNbkNX5vguqDzm5ifEO9sgHrdEqP7W+ZOXvaih
         24uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780250689; x=1780855489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fhEgvzKeZCQs4CyiQC8uzW7u92ha6iJGj4bzQloVlmc=;
        b=FLnKhDyVQVzQr2/u0bpVw598qPGAgf51/FM+8i1gXSE3HhtXlcbe1kYm/QgBEyP6Al
         WmA2D8Z3HoR+NZIOiTwlgG5IVeqB6mVGRYbMiMXRgy46Mbv3dDTZLFMxkZPXnFa2c5kA
         hZklqW1V7PYYgIzRaiRct0sh5R2+/AJS7ZMWyj6UvVqa6maVO1tLimJyllFyJt5g1TVr
         ppZBw9IUkJrhuQzotPVdJjzkkukezOLfOrVtziPkiXd0hZz4eEgXAXsJnv2z+O2RFm4u
         +WlgwoaBHIDCQJRCfQFnntuCS95i3yAcFVPQtVKzZYVsuDAL57Dc+w2KkpfZ0/m46GmB
         zb0w==
X-Forwarded-Encrypted: i=1; AFNElJ8ZtHBWpg9+WFMYmDllY+BpQp1/iFgYhodX32J5/cGz57ED0L+k6c8tAzco0Wh67B93iHuifwE=@vger.kernel.org
X-Gm-Message-State: AOJu0YynScIclwBZt1ZkUh1fozLmwh7/mNHL1UduMuoAmWKDYzUshfct
	KyV4c9Uiz+RhieiUymaJ2lkklsLEsHrLDrvu7YLgHd8TiQlPYuJRMbqkPdBxvibhq0ocIJUwQhz
	r7xRObDRpk/O14qBVKNIo2fSpDWZo7qB/UPsGSTEa
X-Gm-Gg: Acq92OHydq/2pkUogOzrz9WEktyssRqm2fJBXMwnE72gybw0aUNHSQQhVLnwejdMSi2
	TK91eLNdXx07YxF0Z3PgDsgyEfQ6uqO9i6Y9LQVwRdZ11solQPuVanEAsWYGYXq4Abktmfa0uKi
	n2Chst0vk3Lg1JKTaErM9RcnkirrzF3jXzD6bRtJ5B9S2j7IMHCcmNlvahOvTN4Jf0lrc0uEYLK
	RwUXfZFytlm6tfHdcDkQ6nyRFWJV/SqhBvercsj1xPerAv0elgYifvfLsSS8v90S2MQn/F3goj0
	wPFcMUm5g6eHfr3Fe4eTgHiQDZMkQzbFb81tzcwrlaDsN4smf4KSD878irl5we/qXC2PY3w3npG
	G3AwAvUJUqJ9QT4OhHnPYePqMC7o=
X-Received: by 2002:a05:622a:5592:b0:509:34b8:a373 with SMTP id
 d75a77b69052e-5173a778afdmr104207931cf.32.1780250688750; Sun, 31 May 2026
 11:04:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260531153946.1627418-1-runyu.xiao@seu.edu.cn>
In-Reply-To: <20260531153946.1627418-1-runyu.xiao@seu.edu.cn>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 31 May 2026 11:04:37 -0700
X-Gm-Features: AVHnY4JtdL53ilgUiMTNnL2xIGvNC3MhuRWAIyGf-0ExL-UdcyIiDBNlspfYPTE
Message-ID: <CANn89iK_YLvUJf60PkFy-EZwueifRJXaZGJ5pWegN9NLsXO-mQ@mail.gmail.com>
Subject: Re: [PATCH net] ipv6: use READ_ONCE() in ipv6_flowlabel_get()
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 31, 2026 at 8:40=E2=80=AFAM Runyu Xiao <runyu.xiao@seu.edu.cn> =
wrote:
>
> ipv6_flowlabel_get() still reads the shared per-net sysctl fields
> flowlabel_consistency and flowlabel_state_ranges with plain loads,
> while writers update them through proc_dou8vec_minmax(). These checks
> run in the live IPV6_FLOWLABEL_MGR path, so lockless plain reads leave
> KCSAN-visible data races and can make the policy checks observe stale or
> inconsistent values.
>
> The race can be reached on a running system by toggling
> /proc/sys/net/ipv6/flowlabel_consistency and
> /proc/sys/net/ipv6/flowlabel_state_ranges while another task repeatedly
> issues IPV6_FLOWLABEL_MGR requests with IPV6_FL_F_REFLECT or a
> state-ranges flow label.
>
> This issue was first flagged by our static analysis tool while scanning
> lockless IPv6 sysctl readers, then manually audited on Linux v6.18.21.
> The IPV6_FLOWLABEL_MGR paths were runtime-reproduced with QEMU/KCSAN by
> concurrently flipping the two sysctls while TCP reflect and UDP
> state-ranges setsockopt actors exercised ipv6_flowlabel_get(). KCSAN
> reported races between proc_dou8vec_minmax() and the two plain-load
> sites in ipv6_flowlabel_get().
>
> A narrower second-round UDPv6 + IPV6_AUTOFLOWLABEL send-side reproducer
> also hit the inline ip6_make_flowlabel() reader through
> __ip6_make_skb() / proc_dou8vec_minmax(), but that site is already
> fixed in this tree by commit ded139b59b5d
> ("ipv6: annotate data-races from ip6_make_flowlabel()"). The remaining
> plain readers in this tree are both in ipv6_flowlabel_get().
>
> Use READ_ONCE() for those remaining sysctl reads so they follow the same
> lockless reader contract already used by other IPv6 sysctl readers.
>
> Build-tested by compiling net/ipv6/ip6_flowlabel.o on x86_64.
>
> Representative QEMU/KCSAN reports from the two target reader paths:
>
>   BUG: KCSAN: data-race in ipv6_flowlabel_opt / proc_dou8vec_minmax
>   write: proc_dou8vec_minmax+0x206/0x220
>   read:  ipv6_flowlabel_opt+0x6d8/0xd20
>          do_ipv6_setsockopt+0x873/0x2220
>          tcp_setsockopt+0x72/0xb0
>
>   BUG: KCSAN: data-race in ipv6_flowlabel_opt / proc_dou8vec_minmax
>   write: proc_dou8vec_minmax+0x206/0x220
>   read:  ipv6_flowlabel_opt+0x129/0xd20
>          do_ipv6_setsockopt+0x873/0x2220
>          udpv6_setsockopt+0x21/0x40
>

Please cut the verbosity, we do not need to copy/paste fifty lines
just to explain the obvious.

I hope you understand there is no serious bug here, KCSAN is a
debugging feature, not a production one.

One or two lines should be enough, you can take a look at
f062e8e25102324364aada61b8283356235bc3c1 ("ipv6: annotate data-races
in net/ipv6/route.c")

Also Fixes: tags are going to trigger extra work for many stable
teams, for no reason.
