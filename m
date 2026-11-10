Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=66.163.184.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794327240;
	b=gHxz/esX+NyGsD/yiPsazukROhOVklggfYBToGuD9w51Ck9v5XktJNxRYKy4aW4hTU13
	 ReHVUrHySHASyaQig1AxMS52B6LiQnaJuOBNXNb5wa9s5MIjvl3caQf2bg7Tnl0FftWIU
	 gJsnMe9vXDqTM+cGBQZIePe7pK9GqZF1/aEVaY8a1MSkPtLh/eI6MIhUGNoSbjH8HOCGP
	 5AQBvGutUEopv89lNZaB+el32IAkLSKIVoSJ8BDZPcdJP+j5vneyCYTw4jDlYTT41lM0t
	 pAMmEuxjrJ67acrf7khENv3uuFTQvtNNVdXvcMHc4MbgZTk1srqvfgl1Iu6U/TA/KTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794327240;
	h=DMARC-Filter:DKIM-Signature:X-SONIC-DKIM-SIGN:X-YMail-OSG:X-Sonic-MF:
	 X-Sonic-ID:Received:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=g3puA/Rs8Op3gQUg0J/vl+syCCZwXxu4Foqvmyce9W4=;
	b=237paeK9KN3DB4PKfwTmpc6f1yCDLms4MdXPaG+RGaK5R/DCsQ0La5c/BzJhiQqhcH+4
	 HExRVL/+EMVdKDD8bRcHgGZRGil+r4609jB6eCbB6KmpACKi7Qskao2r156076eDpp/Ux
	 xpWMzjZyaYA/d0P0OROzv/aEcBM7E6tZoRgV9UrqsMAQH/rcdaNmqNm5z88dMXrec2fNZ
	 L4yFFDymnvuarRJE9UEFLstGc8gZpAvd8ZuZQ+W/SnqjMSiOBUE4s2rZfJjzqfVbRr09o
	 duIAV5B8jlxRjy9gg8Yw+ZW5DwEPLAPGXd1iCKAXA/he5p/pPSAe8B0p5KDGu44vKQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=schaufler-ca.com;
	spf=pass smtp.mailfrom=schaufler-ca.com;
	dkim=pass header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=RDGd6J64;
	arc=none smtp.remote-ip=66.163.184.49
Received: from sonic317-38.consmr.mail.ne1.yahoo.com (sonic317-38.consmr.mail.ne1.yahoo.com [66.163.184.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985D0606A337
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 16:13:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 985D0606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=RDGd6J64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1794327238; bh=g3puA/Rs8Op3gQUg0J/vl+syCCZwXxu4Foqvmyce9W4=; h=Date:Subject:To:Cc:References:From:In-Reply-To:Content-Type:From:Subject:Reply-To:Content-Type; b=RDGd6J64KFdUM7VGvUfJOJ8S39HfQojQbc02rHRHnll4+eFp09C8JD6kW8aBOQLyrqcKGr09PqSQWggmf2bfP9Vhj6Ope4/1O7EHKejyYQi59nBV5GLSE0Mt47vDBq8/eSYpTzOP065mJIuWwTzB8Frbmzr1bRSNaNCceXs6fsVHkW5xQcnUh3twnWE32aF9l35SVlz0GPlOQdhXi8a1Lv7heecxMJuENe5Mm07v/XnTfVhUI90f81+5pxtKs16ZyZ1dBHONujX86KEr8oFHMAXmZZWU796BbMWTn0fb4rLGhoyytHv1F0nrVY3xsiJrZOTdtlfpVEy3yMrKFWNwEw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1794327238; bh=sYEQKp0KtFvQAK0J3M4QRw/Tkxc1uvwLJaeWJQ8gWyZ=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=BwudvB+03jhVnO10NtONX7aiHcEuZP5bhu5eG/BN0jxXhZmUudkpUnYCE1m7KXbFIBoi5+m1c4k0Jkh3LdYjJm/Jp2lo7/5h3H7GJwL+cSj5G0LQ3rC02xp+Db0QAoeHdKgoVCzGep5TVAqC3Yq4uYu9qBiMTU4x444Ysy/OaSw9+yGk8nbHmxvUKuMqlpoKwmsy7sbGhMpQA27xXFQovpYTxcDOclmuAadh+IhsAQFlkB/PDw3uPsMVwpbJVbSsn0iQWd6YSvx7pYYWz5VAQsnU738WymI8Z4LIo1aK/908HH7j4MmuOOP07fBh7jrpoWGIi7Ads5qsXEbvUFTkqg==
X-YMail-OSG: 4a8g204VM1n9PqiRa7yv3CpcO8VH9DBXllKXBFIvB8iIKOCdy1oyCJDXz.qc1xz
 pikdKsSa0vyEI_0VrAIE.SJA80Wb.KBtgC49c6.wmwlO1amPEf0yHRhYnABpmItnZOEsIKqpGPCA
 oFFeOEUyit70BQmpM1.kjy7Vm17d54mv1rfu8lS6v.xU.PwtD6Bp.tfE3ojQbM.C6X7rGGLNKRNa
 zetOw2TVFmA1A.wnSWTwZiIEEl_rEKknXXH6u7TXA_6_.XOKDDySO..E28RubUtd74UWM2Uv8aZ_
 v0qezE8MJ9WFmzj_9i481qgsj9tyGjXb.awkKulhb9NgB.GhHC1L5FcOxOYG36TOWScQXrKWEq8m
 m3A26J2RlJroVkRXbo2HrImRvDzsXe.jNd8qxSAqoInFulAmasIRdTkavo9UabjpDQLtm3bJMHdV
 ravk_TH6Xa9rSX5Xg4m4azf2JyThWCMO1DZI2Iwm27HSv6E8wWqivGCVTmA.XhwJdW0Zndq4OxfE
 nKxwlOCbPgcB3_BAsWxXug80z.gwtjyk3LfFwbEPzwfgF0m92XC_AOaDemlFRwDWj2XeFcvo8.7c
 PH3XDwJ5SykDe_Ic_2r9Bpet52fWyXiaOzqJO7STLFBNRoJp1dklQesTH2iX0n48cKb8wst_HBYS
 1.NXayAYbPR6lCIkccrKXMOCPKu6rLinl.w3jm7XMf7TdAj81lrNRaj54SQt4JDxl3_er44tSj6e
 vVZsV.6stxY21Xpe12CsWtuJ9i0W.CSkIK8txHnnWvh._cdVb6EyulHbkskfu3hPwFovNR75EV_R
 Xt4rZscdTC6VPrG2kU.P8MyZWjz_fcvHR0dZyBP5KlCTTtjhXRk9kRy3QjNsorL5.A6B1cfFEaAk
 _AEKEYP8BruqiPLlAgyFM8Z.8u_2OGdd1jDvSovuE8xLfaEyirmGRLyEfD_XyKP7wTK.PqW4K932
 lAsWrGoJLGjTa_ZbrjXR0igCzNFg_3hq1yU82MXS0kNXiCi3KmKaj1K51gy0s9lK1BeBk1OM5xNY
 Hutcgt47SRJCIBJucehLSDs3cOIM9YvPDQ5d0WIqaVApG7PETw0Qa9zJzQFUVgRersz5BDaUL5DV
 as3fiZVF.ftPgP5q9imZs_5DBiNy16gaqiyu6Clsoxd3B8HJ3FXDMCMfP.KNaWKbI5fkZ0nvs85Z
 L1bYXbd0G3G5W51iQjtuAIokuU94jV6NquWJPuJfGg.kx9axW0MnCJEAVdaqvaIK6dYG29Hzoq0y
 _siDbT2UVD.SC_Ai7d7GRsGNuuS8Xf1IDNCAqq._UIyl36r1V4JeNck45lHJwh1wC.UyM9PJ3IgU
 cXD5Yef270fy_7uj6dJxB9we1gQ6.GdeQLh.uM35x_9iidC3zFdGLJB08ZieRG.zX5EweOVHoV29
 w8pLRtlJq6aVZzaYD_eLA.4v_pg1H3zbqG_6FZwReQ3aRu__yALuggSZTDZBge5z4DD3cyCKdXuJ
 fdAXYhvzhfgYFV7ebT7Jepsh0QgK_USUXRHyKus5c5eSqqTfnDOmiq8IuOoWzvWRM.ttHHmPtEX_
 tnucnxdlFSvCuxYNs.FRn0g6mvqli4vnzySQq1yUfqopylR8eNQmr2AX2o.xF5fu2KxVwE3P5vWM
 aGNGu70BGvxgkIEGTXdBBlh_3XQI5U0HwzNfP38mdUhjjGqNThgAHW9.eDNG05hJsPKCtt4QV18c
 rqcJKhYzwhPSY74xsUslsJa6orTvPYlbC0xgIVi98r34bEEa7c_TGBfIhp41p6fsHkEt6uu.p64w
 Eq77mjiPzmnx54fHtet_cyCF6RbW15Rm3_o4syW9iXsVKyhCGdL_3ZVp32E284C2FFy_leaYePZJ
 87zzdzIRQCNxYkPXQF8QiWVms3NaGb4xfgV67vTbBKeyaB2W9RPIAzGoqfqS9maZDETnLp6oKgOu
 3j7Cb9WsrP2sfJ3tIt229KLDQoA_CZshPnym48HYnJaVivYYeM2j7zdFKsYy8KKwbWH4Hixz86lP
 7CW1LIX.T0a_eUIXxlUOjPr1Otm.QLTeQ__8p_.5prn1LJeG5eueWUUJ7ybnYqsjFOHBxUG8hZHk
 xdpHjuFhEIy7ilpVYrOEIu5pP7qD9KVwJ6wI0npIhNiJHyMQudG2.G.mWXxgaX48oKnM8gJvG6o1
 CnEd3mACQAjw79eZXQh1OKhbiKuskcH05P2CxD3iKGkvPzxmlVmQQ35xAZJ9HzZy6Z9KPZ1rRIfv
 yNhawAEJ1APH1m125O0E7u6qAmo3C30Xw180TcsLCbqiSZiW69D8IBf05Vp1NrB9JfAW1IUiUXZy
 gsmLO8BBi_PZmmcdoWZRwhFNlX8GNtbao
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: cfdf2d2a-b498-44b5-958c-5f67e753d496
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Tue, 10 Nov 2026 16:13:58 +0000
Received: by hermes--production-gq1-fd7994565-nddcd (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 477e123a5d70e851d8294a1398b4519e;
          Tue, 10 Nov 2026 16:13:53 +0000 (UTC)
Message-ID: <b943c17c-32a2-4c59-9037-a7f41bd163ea@schaufler-ca.com>
Date: Tue, 10 Nov 2026 08:13:50 -0800
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
Subject: Re: [PATCH net] cipso: stop modifying live ip_options_rcu
To: Paul Moore <paul@paul-moore.com>, Jann Horn <jannh@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>, Simon Horman <horms@kernel.org>,
 Stephen Smalley <stephen.smalley.work@gmail.com>,
 =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>,
 netdev@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org, selinux@vger.kernel.org,
 stable@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>
References: <20261106-cipso-rcuopts-v1-1-31ae931d7a0f@google.com>
 <CAHC9VhR+U3i8xNce8Ps8k76EZr_AeVf+fHET_Ncu1+yO1G2zSQ@mail.gmail.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhR+U3i8xNce8Ps8k76EZr_AeVf+fHET_Ncu1+yO1G2zSQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.26943 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 11/9/2026 12:13 PM, Paul Moore wrote:
> On Fri, Nov 6, 2026 at 4:40 PM Jann Horn <jannh@google.com> wrote:
>> cipso_v4_delopt() operates on the ip_options_rcu of a socket or a request
>> socket, and tries to remove CIPSO options from the middle by moving all
>> subsequent options.
>> That's not allowed - ip_options_rcu can be read locklessly and must always
>> be consistent. For example, ip_options_undo() reads trusted offsets and
>> length values from the options buffer.
>> Fix it by doing the modification in a copy.
>>
>> The core change is in cipso_v4_delopt(), the rest is ugly plumbing to
>> propagate memory allocation failures.
>>
>> Triggering this bug requires that the system is configured to use CIPSO.
>> (Setting up CIPSO requires privileges in init_user_ns.)
>>
>> Fixes: f6d8bd051c39 ("inet: add RCU protection to inet->opt")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Jann Horn <jannh@google.com>
>> ---
>> I've sent a separate mail with a reproducer to Paul Moore.
>> ---
>>  include/net/cipso_ipv4.h     | 11 ++++++-----
>>  include/net/netlabel.h       | 11 ++++++-----
>>  net/ipv4/cipso_ipv4.c        | 16 +++++++++++++---
>>  net/netlabel/netlabel_kapi.c | 24 ++++++++++--------------
>>  security/selinux/netlabel.c  |  5 +++--
>>  security/smack/smack_lsm.c   | 14 +++++++++-----
>>  6 files changed, 47 insertions(+), 34 deletions(-)
> Thanks Jann, this looks good to me.  In a perfect world it would be
> nice to get Casey's ACK on the Smack changes, but since they are very
> minor and basically just pass the return code through I think it's
> okay to merge this in another day or so if we don't hear from him.

I don't see any reason to wait for my testing to complete. I'll shout
if anything fails.


>
> Acked-by: Paul Moore <paul@paul-moore.com>
>
