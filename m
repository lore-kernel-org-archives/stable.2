Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E80B44C65C
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 15:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=148.163.148.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786030324; cv=pass; b=TbAOj33y5deMr71X+yUhmQXjV3tmDp3sduHHbgjbN4sJ5QyqY8WF7kNzP2VnuY+796564I3R/OMQqr1PFF7GBj6JSEsrFytceuyjC+3QqmuhSjmZwbUhXgMlFvy3KfB4OeN70Oo7GwuRHuX8JIN1Ab7vx/eWzmK+uDIyV/BGe1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786030324; c=relaxed/simple;
	bh=q1yKAchAKLYq079ovpGA477d3rJNusw7Xe8p+FR68lg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nALN0/IDocXjL0YIdWY0KAx64Fgdb1ex6XE2D/Bc69iDsM158BnkQCTScw9cx5jJBWYvq3SgMLTqBQPtEfjn5mzxZ37gzjmwqQrGHBn33cZcxhSZNMw+5FJlzKxc4JfT/2cew1Seh4ZaHnYyZ3Nb2FuhZSLlT54iVAmRwqpgt8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=cD4zTm5M; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=jUwr7YyE; arc=pass smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="cD4zTm5M";
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="jUwr7YyE"
Received: from pps.filterd (m0354652.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676F1Fgf791548
	for <stable@vger.kernel.org>; Thu, 6 Aug 2026 15:32:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=c2fkWs3IPyqlvD9JKIug3ApdmdvPne7OgC9UgDf+NxM=; b=cD4z
	Tm5M17fPCDrNyQnDpnqttK1cC6kuMPVg4/jD/NafaBCKl0S12uY23MLt8b4AzTR1
	tNtAlGU6iP65NOCAbZGM/AFS1P8A8jFJtgC+Gka/cS6al6ZUwTehMeQPyb49rJQ/
	ju69mZ7d/ia/w2ssTJghneL2trmQpwiu1JI2o4ewFKbpqsE6YwXRn0dDomX5s3g/
	TzyMqV1CTrn8xM9VTU4dBjoou0s9LDokE/Lr5b8h6sM33N7AXcM7VGNgAH/pGgMd
	cZseJx5SSRaCvi1pYSw14VZx4tyjkzymIS24edQKmC4N7Wsh7W7pzQS0ATIUeCok
	yJesokBCRMEHIY5+8g==
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com [74.125.224.72])
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4fv69t6jfs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 06 Aug 2026 15:32:01 +0000 (GMT)
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-664e15b53d3so5822025d50.3
        for <stable@vger.kernel.org>; Thu, 06 Aug 2026 08:32:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786030320; cv=none;
        d=google.com; s=arc-20260327;
        b=KHLQhQftwlZ1kdyOxpmSwsJbTK0/6/XH47Zd3sFtyoDA8eG5A83xdLl+mQftdVXq0g
         uJNBNhsuothP+RhstNPk/Yja4whAcsyQ9vyFJjHhsJ69kI4Buv5ar0OmCVQ5x4LkekJo
         Lcv0y3oTlEZ3hrQHGQLaxcyDsqypYh3k/9C9zj5Qdpd76Yi+mMrOCOJs+au0sUD2iApP
         sFjtxT2KlkBzdgcdP+nJAzdSMj7maD3E6cw9tvSEdvSXByXFBbBIw4ipK+piM4zXGaNt
         qF4wDLeWP8W/ZBfZT/PbsriIMQHCC1w2Uc2m58O3ca9w/ni9JgsqApdevROYguD4H3Ov
         LJ5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=c2fkWs3IPyqlvD9JKIug3ApdmdvPne7OgC9UgDf+NxM=;
        fh=dKc0ZF1NlJZnSdeV/tpNowR4EQosXDOk/f9QbcBjGJA=;
        b=k/zVS++C709KkxESVx6GWp4DxgNvSt26K1yiPEkih2Iux0wajZTk/xl6m+n2KIIkVT
         ABbmJ5WdZzZXegmUNXixuZ1+hmgHdCf6mHsjeldx2vl618eCl02PjHkjecLnBiNW5IC8
         mLY7fdkl4/cx2gfu/dfN2fEWlMg9Wi+wmvtuVWTLmtRyTkh9v1CRil+2jADIITJrGxgz
         aRLRv3Htm4q3LmhmUPQC3Pc3cvnMf99EbkjS5VvZWDizXYMhFo8/WOsLRcmGGw/K9dR3
         3FL+82bHPSFgWJpfwD06e/c17bOs9HDECNAN5B3zUE9oQjooSaR7VC8nj1yntz00POKG
         xtkw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crowdstrike.com; s=google; t=1786030320; x=1786635120; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=c2fkWs3IPyqlvD9JKIug3ApdmdvPne7OgC9UgDf+NxM=;
        b=jUwr7YyEutR2ntg8mjiTkWr8G03wYaEMxMSDpwpeIO060yep4vdjVdLNRvdpnYyHTh
         Q2ja/+7W1N89qUtLLHRF2mQFXrKXQw1q7TKbCzzFGzCy8phwlVgFemybh4MsP+CUcdjM
         lH3nwDnpqcmGChjsCbjpWZo8NYW4J3mXH8mmmFURQgcdbKZ6uwkM5LI8SnhJQM7acml/
         nJF1EDne5owqizd5ct1e56AakdqqUXBYpxOm46SB/gVYfEap/FbxbnM7SCuYg+6J+inK
         m/vmdXVQn4/+CKbdIOqRKB//rjFCjK81hRMhXyWjyAMGfCvtjZljQDehl4TxvX+xCLXI
         vkGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786030320; x=1786635120;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c2fkWs3IPyqlvD9JKIug3ApdmdvPne7OgC9UgDf+NxM=;
        b=AZAHFLDuGzcSGPWTSAZNcVALd/DZPf00Uk7PuUG9ibVc7hI0cTy6ddG5wU1FI1RBSo
         3k83UiGNhhQa/yusiX5JVZr/SYhY/gif+vvLJ/qAIISucYatwPBLCmZCu9C4m5QCD/LA
         H8oY8OIH8MJf/hKQBXYMWETgtgugCVgoctjKpQ5juMECOkqTJcE4T/IkVpbV7n3T6gv/
         aK4MOlU0nW8D+jzYehXJZ76dIn3AEraMqICQxscqZJl7cTyTv0fBGWG/gaXLfKEUg+Kg
         9KmpTFkuzhQGG2d7V30/l/EApMC8Dgt9y/Wvh0TmwZFP9PhE95ycQhqn669aNr3OV7+m
         6WGQ==
X-Forwarded-Encrypted: i=1; AHgh+RrzGXysLmyDG8/7+S2gjbrWP9G8yrId/RBSravfgx0VCN4pi9D4D0MQftCxyL9fQuvVowYKRYw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk+NAalC7g+WzIkutNmYzv8Fw0/MykgZIVtMqCCJvZMaqzJX+O
	sKAgUNdpsDxTLbG+avDzFFj0POWN+rZhCLTHX32AEM6ONdr2tnWDRdRb0aEFWVV8SO8TjT8E8Hv
	Dxx1flTGvj0QabqZ/PJPViKq33AiDknxozhNSMEfjWsoVmggFkNoIwk0nXnHezTAv+z92kLZwJZ
	n3L1KNv4XJLCN8E+p4agnLzrhReyFzhXRB
X-Gm-Gg: AR+sD12JUVqicNHi8EpH0qzFVBUKyMAVCi7TPygV6RDyJnFkrXwFf+8WA3thinpA0SK
	tvC1lxcYqz6zKrK9cesnzXObxr7j+UiBQfH6SrZz3KIHj46uTjDlPG7Ii9KWXQTR5ei5o5lmJmQ
	w6jqQ3CUUc3AL2EXeAqz3E8IdF6RPY0SLVaO5wM42O+HrxeiO/NlRw61MPqg==
X-Received: by 2002:a05:690e:488a:b0:664:bd5c:6e72 with SMTP id 956f58d0204a3-6699aa7511dmr7229025d50.34.1786030320353;
        Thu, 06 Aug 2026 08:32:00 -0700 (PDT)
X-Received: by 2002:a05:690e:488a:b0:664:bd5c:6e72 with SMTP id
 956f58d0204a3-6699aa7511dmr7228964d50.34.1786030319671; Thu, 06 Aug 2026
 08:31:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731175358.3542156-1-andrey.grodzovsky@crowdstrike.com>
 <20260731175358.3542156-3-andrey.grodzovsky@crowdstrike.com> <am0-QoUNQo4p2sBg@redhat.com>
In-Reply-To: <am0-QoUNQo4p2sBg@redhat.com>
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Date: Thu, 6 Aug 2026 11:31:47 -0400
X-Gm-Features: AUfX_mw1nwxsETix0HLa6WjJrBSSAU1_0A9CQBJUP5Fq4BDIA8mjk_ZZNVuhTmY
Message-ID: <CAOu3gNhFL+1JmWRVwJVq4xUn-8mENkNwYexCwpFZ8FaZY82SRw@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 2/2] selftests/livepatch: update
 test-ftrace.sh for deprecated ftrace_enabled
To: Joe Lawrence <joe.lawrence@redhat.com>
Cc: bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, rostedt@goodmis.org, mbenes@suse.cz,
        corbet@lwn.net, jpoimboe@kernel.org, shuah@kernel.org,
        jolsa@kernel.org, mhiramat@kernel.org, stable@vger.kernel.org,
        linux-open-source@crowdstrike.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=QYJWeMbv c=1 sm=1 tr=0 ts=6a74a8f1 cx=c_pps
 a=VEzVgl358Dq0xwHDEbsOzA==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=KZhmPCYDdY0A:10 a=VkNPw1HP01LnGYTKEx00:22 a=T2KQ53IYiC3MXPrxx8bB:22
 a=2KvRFfd_T_-xjmS8C1aD:22 a=ngmC-yC5AAAA:8 a=e25ExAebAAAA:8 a=20KFwNOVAAAA:8
 a=meVymXHHAAAA:8 a=pl6vuDidAAAA:8 a=dDW-ktzWsA5qhXuJ1JwA:9 a=QEXdDO2ut3YA:10
 a=uujmmnXaIg8lM0-o0HFK:22 a=P5XVh-r7Nk77isVNjX_M:22 a=Fx-rEtueDibNKiZPBj-h:22
 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-GUID: gG6PYeyuP1_eIw1nw5sTkF_xjmtZ3pj9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDEyMCBTYWx0ZWRfX+ngM4lpx7B1Q
 7ZgOJkeSP/ilZzoNv230cWh4un/K8O5U7Hdc4f8wv6zcd+MkmOA2tU2TpC36vGWIFLeHxCvkZLJ
 exHp4zQzBr/8btnbm/k6WGIIL0FngGq2ivqZsWvnAKifw2IOn2Zk/L7B1B1LvS80bpBO6CPZWOX
 btzE5Jldm9NBnmRPDoD6P8fsOqd000vH8sNHaSZaC9pWMLMjmorUIOk/itIMJn1HU388BKZwJbI
 pFNc7cFGrlzvlt+8jdk3+ZdGqj/upAmlt1X3ks3Y80wjEjiDmt5Bz208Jt4SCWWGVuHGp/HPrvq
 Enlk8AhwN+6oCOFziM7MI3/YcGKnGv5Con4PkovyLuiQuu/qoDIco+OyECLshi7tIzywswcT6i/
 UhtGhlDGROa67OSh5oLp2m7RbBSRlAXb33/9a7q0WgnK7iU7RfA6ABKYTSxGbpI/tDn80pC7PlN
 oLqzApCsTYjT169i90w==
X-Proofpoint-ORIG-GUID: gG6PYeyuP1_eIw1nw5sTkF_xjmtZ3pj9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDEyMCBTYWx0ZWRfX8aE90wjKBouo
 L/j4x4os0nFF7twiDYYh6lskE1htOqJaE1D3hfeb/5EWc3GDDOLXuM5YIgLP83sYYCyAtgsLG5e
 NZ8hAXCNDbrEFLQ4LGBlnH3dcekOGyrMXA7nselz5aACRQoYE+fU
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11867
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 adultscore=0 priorityscore=1501 spamscore=0
 bulkscore=0 clxscore=1015 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060120

Thank you Joe and Steven for your comments; I sent V3.

Andrey

On Fri, Jul 31, 2026 at 8:31=E2=80=AFPM Joe Lawrence <joe.lawrence@redhat.c=
om> wrote:
>
> On Fri, Jul 31, 2026 at 01:53:58PM -0400, Andrey Grodzovsky wrote:
> > kernel.ftrace_enabled=3D0 is now refused on kernels that deprecate the
> > knob, so the old disable/reload flow no longer applies there. Probe
> > for this with ftrace_disable_supported() and keep the full original
> > scenario (disable, fail to load a livepatch, re-enable, load, confirm
> > disable is refused while loaded) on kernels where it still works;
> > otherwise just confirm the write is refused.
> >
> > Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> > Suggested-by: Miroslav Benes <mbenes@suse.cz>
> > Assisted-by: Claude:claude-sonnet-5
> > Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
> > ---
> >  .../testing/selftests/livepatch/https://urldefense.com/v3/__http://fun=
ctions.sh__;!!BmdzS3_lV9HdKG8!zXXcFqHACaJ7PyoFMFh-_8DFTwWSotPltPcR5ezYC87Va=
VkoNZcqFkVTtLbYUQp4DKEh9Z-0WLN8c5sMeyug2BCCuslAibAtHJo$   | 13 ++++++
> >  .../selftests/livepatch/https://urldefense.com/v3/__http://test-ftrace=
.sh__;!!BmdzS3_lV9HdKG8!zXXcFqHACaJ7PyoFMFh-_8DFTwWSotPltPcR5ezYC87VaVkoNZc=
qFkVTtLbYUQp4DKEh9Z-0WLN8c5sMeyug2BCCuslAJf9tNxM$         | 45 ++++++++++++=
-------
> >  2 files changed, 41 insertions(+), 17 deletions(-)
> >
> > diff --git a/tools/testing/selftests/livepatch/https://urldefense.com/v=
3/__http://functions.sh__;!!BmdzS3_lV9HdKG8!zXXcFqHACaJ7PyoFMFh-_8DFTwWSotP=
ltPcR5ezYC87VaVkoNZcqFkVTtLbYUQp4DKEh9Z-0WLN8c5sMeyug2BCCuslAibAtHJo$  b/to=
ols/testing/selftests/livepatch/https://urldefense.com/v3/__http://function=
s.sh__;!!BmdzS3_lV9HdKG8!zXXcFqHACaJ7PyoFMFh-_8DFTwWSotPltPcR5ezYC87VaVkoNZ=
cqFkVTtLbYUQp4DKEh9Z-0WLN8c5sMeyug2BCCuslAibAtHJo$
> > index 30dc677b2f45..7fa4bda70221 100644
> > --- a/tools/testing/selftests/livepatch/https://urldefense.com/v3/__htt=
p://functions.sh__;!!BmdzS3_lV9HdKG8!zXXcFqHACaJ7PyoFMFh-_8DFTwWSotPltPcR5e=
zYC87VaVkoNZcqFkVTtLbYUQp4DKEh9Z-0WLN8c5sMeyug2BCCuslAibAtHJo$
> > +++ b/tools/testing/selftests/livepatch/https://urldefense.com/v3/__htt=
p://functions.sh__;!!BmdzS3_lV9HdKG8!zXXcFqHACaJ7PyoFMFh-_8DFTwWSotPltPcR5e=
zYC87VaVkoNZcqFkVTtLbYUQp4DKEh9Z-0WLN8c5sMeyug2BCCuslAibAtHJo$
> > @@ -126,6 +126,19 @@ function set_ftrace_enabled() {
> >       echo "livepatch: kernel.ftrace_enabled =3D $result" > /dev/kmsg
> >  }
> >
> > +# ftrace_disable_supported() - probe whether kernel.ftrace_enabled=3D0
> > +#    can still disable ftrace on this kernel. Newer kernels deprecate
> > +#    the knob and always refuse the write with -EOPNOTSUPP.
> > +function ftrace_disable_supported() {
> > +     local result
> > +
> > +     sysctl -q kernel.ftrace_enabled=3D0 &> /dev/null
> > +     result=3D$(sysctl --values kernel.ftrace_enabled)
> > +     sysctl -q kernel.ftrace_enabled=3D1 &> /dev/null
> > +
> > +     [[ "$result" =3D=3D "0" ]]
> > +}
>
> Small nit: AFAICT, it doesn't really affect the test pattern, but it
> would be a bit cleaner if this function restored the original value
> instead of always turning it on, like (untested):
>
>         orig=3D$(sysctl --values kernel.ftrace_enabled)
>         sysctl -q kernel.ftrace_enabled=3D0 &> /dev/null
>         result=3D$(sysctl --values kernel.ftrace_enabled)
>         sysctl -q "kernel.ftrace_enabled=3D$orig" &> /dev/null
>
>         [[ "$result" =3D=3D "0" ]]
>
> --
> Joe
>
