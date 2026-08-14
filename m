Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BA5390613;
	Fri, 14 Aug 2026 22:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786748199; cv=none; b=Z0UOtighp/pfSJIUb5JM2ZyKMUs/ZECFp0KKExi2NpB5m37ixu9PHMbLQXHCjARQSp1IXifAGNMdM7CWEuVpm0u3chFHPf/8DCvwgxOdPqR9Laz/+PHn3TnJsJP+kwt04Y83JiHCc9XQdsqGHl03HNbAe3Z+biXsxOLg6RTLQlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786748199; c=relaxed/simple;
	bh=pPtwt9Rj/CD0WdnVJjiyoCyv9cPuh/TKcGvumGpIcHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GdcVPp0S13XHYPDuoPzJp1hZi76KgbOPWPIog6jV5xzcclrLuqEw04B/wFjM42WoR4Ge1kYWNmUNbDa3aepmXBZehdcpTsA/1PAUrupkvYi6unZnGckNyCzciVYsKle7ln+RvvcvmQPRw+8tcZnH2M57T21R3Oxur2TjaiKy6uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C8QtIz/r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C8QtIz/r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1318A1F000E9;
	Fri, 14 Aug 2026 22:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786748197;
	bh=LLFnFhnp99EnYI29eLdFXvcM8Xtxvy/M4cbmIx4N5lA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=C8QtIz/rZ24VbATHU7zfijy8olR+PSXnXTa++kP1UV1pV1HKuUGQkmptJZzLVMHDi
	 FFhyAKcPPCquUZt7nMkrYPnYmk8SzXpvFOJx1jquBP3QMIkMaaXBTja+YBRlcUlEyB
	 vEXHBRup8fnRGHfF2IqxUWoLvPJ2eLn5avEQk5iq3QI0fDTKJyHRt4DLjiwXJYGlqp
	 BH2zNX0bhMD6/gRA/VnWCYg82ulC5NA3Pnqrtgt/3losOPJsNRaRB/QQM/93REXQxH
	 GdCGSxxwUkm01hSB/Qjmq8HoS0RiehzqgA6iB5tp4j/SVytZGj60QtLD81+hZ3EV8G
	 lAfwkgTqyIF9Q==
Message-ID: <fd6e2e14-4fd2-42fb-8edf-818fe9e90a38@kernel.org>
Date: Sat, 15 Aug 2026 00:56:33 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp v2] mptcp: restore full join state in syncookie
 MP_JOIN reconstruction
Content-Language: fr
To: Paolo Abeni <pabeni@redhat.com>, Harshit Varu <harshitvaru666@gmail.com>,
 netdev@vger.kernel.org
Cc: mptcp@lists.linux.dev, martineau@kernel.org, security@kernel.org,
 stable@vger.kernel.org
References: <20260811215135.87756-1-harshitvaru666@gmail.com>
 <20260811222325.90426-1-harshitvaru666@gmail.com>
 <d98287c8-0925-4e70-8cb7-c5703d8145fa@redhat.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <d98287c8-0925-4e70-8cb7-c5703d8145fa@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Harshit, Paolo,

@Paolo: thank you for the review!

On 12/08/2026 11:10, Paolo Abeni wrote:
> On 8/12/26 12:23 AM, Harshit Varu wrote:
>> mptcp_token_join_cookie_init_state() rebuilds the request socket for a
>> MP_JOIN 4th-ACK that was handled under SYN cookies, but it only restores
>> remote_nonce, local_nonce, backup, join_id, token and msk from the saved
>> cookie entry. local_id, request_bkup and thmac are never restored, even
>> though the SYN path saves local_id and computes the other two.
>>
>> subflow_ulp_clone() then reads those three fields and copies them into the
>> joined subflow context (local_id, request_bkup, thmac). Because the
>> request-sock slab is SLAB_TYPESAFE_BY_RCU and not zeroed on allocation, the
>> values are stale bytes of previously freed request sockets, which an
>> off-path peer can influence by sending concurrent MP_JOIN SYNs. A corrupted
>> local_id breaks id-based path-manager bookkeeping, and a corrupted
>> request_bkup misclassifies the subflow in the packet scheduler's
>> backup/active selection.
>>
>> Save and restore request_bkup and thmac as well, completing the state
>> restore.
>>
>> Fixes: 9466a1ccebbe ("mptcp: enable JOIN requests even if cookies are in use")
>> Cc: stable@vger.kernel.org
>> Assisted-by: opencode:deepseek-v4-flash
>> Signed-off-by: Harshit Varu <harshitvaru666@gmail.com>
>> ---
>>  net/mptcp/syncookies.c | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/net/mptcp/syncookies.c b/net/mptcp/syncookies.c
>> index 7f2252634..3c25ff627 100644
>> --- a/net/mptcp/syncookies.c
>> +++ b/net/mptcp/syncookies.c
>> @@ -27,7 +27,9 @@ struct join_entry {
>>  	u8 join_id;
>>  	u8 local_id;
>>  	u8 backup;
>> +	u8 request_bkup;
>>  	u8 valid;
>> +	u64 thmac;
> 
> Is thmac used for passive flows after
> mptcp_token_join_cookie_init_state()? I think it's not. If so just init
> to 0 in mptcp_token_join_cookie_init_state (with a comment) and remove
> remove the new field from here.
> 
> Same for request_bkup, AFAICS both are used in syn_ack only.
> 
> The bottom line is that we don't want to increase `struct join_entry`
> size without good reasons.

@Harshit: I agree with Paolo. So at the end, the v1 was good.

Can you please send a new version with what you had in the v1? Before
you do so, I have a few requests:

- Do not send a new version as a reply to another [1]

- Use 'PATCH net' [1]

- Wait 24h between submissions [1]

- Remove 'security@k.o' from Cc as it is sent to public MLs [2]

- Use ./scripts/get_maintainer.pl to cc the right people [3]

[1] https://docs.kernel.org/process/maintainer-netdev.html
[2] https://docs.kernel.org/process/submitting-patches.html
[3]
https://netdev-ctrl.bots.linux.dev/logs/build/1144354/14744385/cc_maintainers/desc

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

